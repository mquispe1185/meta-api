class PromocionesController < ApplicationController
  before_action :set_promocion, only: [:show, :update, :destroy]
  before_action :authenticate_usuario!, only:[:create,:mis_promos]
  # GET /promociones
  def index
    @promociones = Promocion.all

    render json: @promociones
  end

  def index_main
    @promociones = Promocion.all
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

    if @promocion.save
      render json: @promocion, status: :created, location: @promocion
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

  # DELETE /promociones/1
  def destroy
    @promocion.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promocion
      @promocion = Promocion.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def promocion_params
      params.require(:promocion).permit(:comercio_id, :usuario_id, :desde, :hasta, :titulo, :descripcion, :duracion, :vencido, 
        :prioridad, :estado,:habilitado)
    end
end