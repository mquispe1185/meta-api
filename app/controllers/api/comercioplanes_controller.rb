class Api::ComercioplanesController < ApplicationController
  before_action :set_comercioplan, only: [:show, :update, :destroy]
  before_action :authenticate_usuario!, only:[:create, :misplanes,:index]
  # GET /comercioplanes
  # def index
  #   @comercioplanes = Comercioplan.all
  #   render json: @comercioplanes.order(desde: :desc)
  # end

  # def mis_planes
  #   @comercioplanes = current_usuario.comercioplanes
  #   render json: @comercioplanes
  # end

  def index 
    if current_usuario.rol_id ==1
      @comercioplanes = Comercioplan.all.order(created_at: :desc)
      #render json: @comercioplanes.order(desde: :desc)
    else 
      @comercioplanes = current_usuario.comercioplanes.order(created_at: :desc)
    end 
    render json: @comercioplanes
  end 

  # GET /comercioplanes/1
  def show
    render json: @comercioplan
  end

  # POST /comercioplanes
  def create
    @comercioplan = current_usuario.comercioplanes.new(comercioplan_params)
    comercio = @comercioplan.comercio
    @comercioplan.servicio_anterior_id = comercio.tipo_servicio_id
    if @comercioplan.save
      comercio.update(estado: :cambio_pendiente, tipo_servicio_id: @comercioplan.tipo_servicio_id)
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
        @comercioplan.update(meses: 3,desde: Date.today, hasta: Date.today + @comercioplan.meses.months)
        @comercioplan.update(formapago_id: 2)
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
