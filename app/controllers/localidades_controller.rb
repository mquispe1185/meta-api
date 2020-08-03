class LocalidadesController < ApplicationController
  before_action :set_localidad, only: [:show, :update, :destroy]

  # GET /localidades
  def index
    @localidades = Localidad.all

    render json: @localidades
  end

  # GET /localidades/1
  def show
    render json: @localidad
  end

  # POST /localidades
  def create
    @localidad = Localidad.new(localidad_params)

    if @localidad.save
      render json: @localidad, status: :created, location: @localidad
    else
      render json: @localidad.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /localidades/1
  def update
    if @localidad.update(localidad_params)
      render json: @localidad
    else
      render json: @localidad.errors, status: :unprocessable_entity
    end
  end

  # DELETE /localidades/1
  def destroy
    @localidad.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_localidad
      @localidad = Localidad.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def localidad_params
      params.require(:localidad).permit(:nombre, :departamento_id, :provincia_id, :activo)
    end
end
