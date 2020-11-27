class PromocionesController < ApplicationController
  before_action :set_promocion, only: [:show, :update, :destroy,:set_foto]
  before_action :authenticate_usuario!, only:[:create,:mis_promos,:set_foto]
  # GET /promociones
  def index
    @promociones = Promocion.all

    render json: @promociones
  end

  def index_main
    #@promociones = Promocion.all

    @promociones = Promocion.where('hasta >= ?', Date.today)
    render json: @promociones, each_serializer: PromoShortSerializer
  end

  def mis_promos
    @promociones = current_usuario.promociones
    render json: @promociones
  end

  # GET /promociones/1
  def show
    render json: @promocion
  end

  # POST /promociones
  def create
    @promocion = Promocion.new(promocion_params)
    @promocion.usuario_id = current_usuario.id
    if @promocion.save
      #@promociones = current_usuario.promociones
      render json: @promocion, status: :created
    else
      puts @promocion.errors.full_messages
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
    #render json: {url_logo: "https://s3.sa-east-1.amazonaws.com/api.eira/#{@institucion.avatar.key}"}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promocion
      @promocion = Promocion.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def promocion_params
      params.require(:promocion).permit(:comercio_id, :usuario_id, :desde, :hasta, :titulo, :descripcion, :duracion, :vencido, 
        :prioridad, :estado,:habilitado,:formapago_id,:importe,:costo_diario,:descuento,:codigo,:imagen)
    end
end
