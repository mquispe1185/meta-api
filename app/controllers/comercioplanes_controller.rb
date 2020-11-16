class ComercioplanesController < ApplicationController
  before_action :set_comercioplan, only: [:show, :update, :destroy]
  before_action :authenticate_usuario!, only:[:create]
  # GET /comercioplanes
  def index
    @comercioplanes = Comercioplan.all

    render json: @comercioplanes
  end

  # GET /comercioplanes/1
  def show
    render json: @comercioplan
  end

  # POST /comercioplanes
  def create
    @comercioplan = Comercioplan.new(comercioplan_params)
    @comercioplan.usuario_id = current_usuario.id
    if @comercioplan.save
      comercio = @comercioplan.comercio
      comercio.update(estado: 1, tipo_servicio_id: @comercioplan.tipo_servicio_id)
      render json: comercio, status: :created, serializer: ComercioSerializer
    else
      render json: @comercioplan.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comercioplanes/1
  def update
    if @comercioplan.update(comercioplan_params)
      render json: @comercioplan
    else
      render json: @comercioplan.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comercioplanes/1
  def destroy
    @comercioplan.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comercioplan
      @comercioplan = Comercioplan.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comercioplan_params
      params.require(:comercioplan).permit(:comercio_id, :tipo_servicio_id, :formapago_id, :estado, :desde, :hasta, :importe,:usuario_id)
    end
end
