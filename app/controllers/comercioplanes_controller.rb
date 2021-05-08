class ComercioplanesController < ApplicationController
  before_action :set_comercioplan, only: [:show, :update, :destroy]
  before_action :authenticate_usuario!, only:[:create, :misplanes]
  # GET /comercioplanes
  def index
    @comercioplanes = Comercioplan.all
    render json: @comercioplanes
  end

  def mis_planes
    @comercioplanes = current_usuario.comercioplanes
    render json: @comercioplanes
  end
  # GET /comercioplanes/1
  def show
    render json: @comercioplan
  end

  # POST /comercioplanes
  def create
    @comercioplan = Comercioplan.new(comercioplan_params)
    comercio = @comercioplan.comercio
    @comercioplan.usuario_id = current_usuario.id
    @comercioplan.servicio_anterior_id = comercio.tipo_servicio_id
    if @comercioplan.save
      
      comercio.update(estado: 1, tipo_servicio_id: @comercioplan.tipo_servicio_id)
      render json: comercio, status: :created, serializer: ComercioSerializer
    else
      render json: @comercioplan.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comercioplanes/1
  def update
    if @comercioplan.update(comercioplan_params)
     
      comercio = @comercioplan.comercio
      case @comercioplan.estado
      when Comercioplan::PENDIENTE 
        comercio.update(estado: Comercio::DEFAULT,tipo_servicio_id: @comercioplan.servicio_anterior_id)
        @comercioplan.update(desde: nil, hasta: nil)
      when Comercioplan::APROBADO
        comercio.update(estado: Comercio::DEFAULT,tipo_servicio_id: @comercioplan.tipo_servicio_id)
        @comercioplan.update(desde: Date.today, hasta: Date.today + @comercioplan.meses.months)
      when Comercioplan::VENCIDO
        comercio.update(estado: Comercio::DEFAULT,tipo_servicio_id: 1)
      when Comercioplan::RECHAZADO
        comercio.update(estado: Comercio::DEFAULT,tipo_servicio_id: @comercioplan.servicio_anterior_id)
        @comercioplan.update(desde: nil, hasta: nil)
      end
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
      params.require(:comercioplan).permit(:comercio_id, :tipo_servicio_id,:servicio_anterior_id, :formapago_id, :estado, 
      :desde, :hasta,:meses, :importe,:usuario_id,:pagado,:codigo)
    end
end
