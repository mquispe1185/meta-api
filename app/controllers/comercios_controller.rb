class ComerciosController < ApplicationController
  before_action :set_comercio, only: [:show, :update, :destroy]
  before_action :authenticate_usuario!, only:[:create]
  # GET /comercios
  def index
    @comercios = Comercio.all

    render json: @comercios
  end

  # GET /comercios/1
  def show
    render json: @comercio
  end

  # POST /comercios
  def create

    @comercio = Comercio.new(comercio_params)
    @comercio.usuario_id = current_usuario.id
    if @comercio.save
     @comercios = current_usuario.comercios.where(activo: true)
    render json: @comercios
    else
      puts @comercio.errors.full_messages
      render json: @comercio.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comercios/1
  def update
    if @comercio.update(comercio_params)
      render json: @comercio
    else
      render json: @comercio.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comercios/1
  def destroy
    @comercio.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comercio
      @comercio = Comercio.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comercio_params
      params.require(:comercio).permit(:nombre, :domicilio, :telefono, :celular, :web, :horario_desde, :horario_hasta, 
        :horario_desde2, :horario_hasta2, :rubro_id,
        :facebook, :instagram, :twitter, :latitud, :longitud, :email, :provincia_id, :departamento_id, :localidad_id, 
        :descripcion, :usuario_id, :entrega, :activo)
    end
end
