class Api::PromocionesController < ApplicationController
  before_action :set_promocion, only: [:show, :update, :destroy,:set_foto]
  before_action :authenticate_usuario!, only:[:create,:mis_promos,:set_foto]

  #estado: 
  #0:default/pendiente, 
  #1:habilitado, 
  #2:nohabilitado, 
  #3:procesada y terminada

  # GET /promociones utilizado por admin
  def index
    @promociones = Promocion.all.order(created_at: :desc)
    render json: @promociones
  end

  def index_main
    #utilizado en el inicio
    @promociones = Promocion.where('hasta >= ?', Date.today).where(activo: true)
    render json: @promociones, each_serializer: PromoShortSerializer
  end

  def mis_promos
    @promociones = current_usuario.promociones.where(activo: true).order(created_at: :desc)
    render json: @promociones
  end

  # GET /promociones/1
  def show
    render json: @promocion
  end

  def create
   
    @promocion = Promocion.new(promocion_params)
    @promocion.usuario_id = current_usuario.id
    #@promocion.formapago_id = 3 #Para que a todas las promos las cargue con pago GRATUITO.
    @promocion.estado = "gratuito"
    if !params[:formapago_id].present?
      @promocion.formapago_id = Formapago::GRATUITO
    end

    if @promocion.save
      @promociones = current_usuario.promociones
      render json: @promocion, status: :created
    else
      render json: @promocion.errors, status: :unprocessable_entity
    end
  end

  
  # PATCH/PUT /promociones/1
  def update
    if @promocion.update(promocion_params)
      render json: @promocion
    else
      render json: @promocion.errors, status: :unprocessable_entity
    end
  end

  def habilitar
    @promocion = Promocion.find(params[:id])
    if @promocion.update(estado: params[:estado])
      render json: @promocion
    else
      render json: @promocion.errors, status: :unprocessable_entity
    end
  end
  # DELETE /promociones/1
  def destroy
    @promocion.destroy
  end

  def set_foto
    @promocion.imagen.purge

    @promocion.imagen.attach(params[:imagen])
    if @promocion.imagen.attached?
        @promocion.update(url: "https://s3.us-east-2.amazonaws.com/meta.app/#{@promocion.imagen.key}")
    end
  
    render json: @promocion
  end

  def actualizacion_diaria
    @promociones = Promocion.where('hasta < ?', Date.today)
    @promociones.update(vencido: true)
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promocion
      @promocion = Promocion.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def promocion_params
      params.require(:promocion).permit(:comercio_id, :usuario_id, :desde, :hasta, :titulo, :descripcion, :duracion, :vencido, 
        :prioridad, :estado,:habilitado,:formapago_id,:importe,:costo_diario,:descuento,:codigo,:imagen,:vistas)
    end
end
