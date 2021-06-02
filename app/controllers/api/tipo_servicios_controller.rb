class Api::TipoServiciosController < ApplicationController
  before_action :set_tipo_servicio, only: [:show, :update, :destroy]

  # GET /tipo_servicios
  def index
    @tipo_servicios = TipoServicio.all

    render json: @tipo_servicios
  end

  # GET /tipo_servicios/1
  def show
    render json: @tipo_servicio
  end

  # POST /tipo_servicios
  def create
    @tipo_servicio = TipoServicio.new(tipo_servicio_params)

    if @tipo_servicio.save
      render json: @tipo_servicio, status: :created, location: @tipo_servicio
    else
      render json: @tipo_servicio.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tipo_servicios/1
  def update
    if @tipo_servicio.update(tipo_servicio_params)
      render json: @tipo_servicio
    else
      render json: @tipo_servicio.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tipo_servicios/1
  def destroy
    @tipo_servicio.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_servicio
      @tipo_servicio = TipoServicio.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tipo_servicio_params
      params.require(:tipo_servicio).permit(:nombre, :descripcion, :importe)
    end
end
