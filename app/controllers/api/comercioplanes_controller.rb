class Api::ComercioplanesController < ApplicationController
  before_action :set_comercioplan, only: [:show, :update, :destroy, :admin_update]
  before_action :authenticate_usuario!, only:[:misplanes,:index]
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
      @comercioplanes = Comercioplan.activos.order(created_at: :desc)
    else 
      @comercioplanes = current_usuario.comercioplanes.activos.order(created_at: :desc)
    end 
    render json: @comercioplanes
  end 

  # GET /comercioplanes/1
  def show
    render json: @comercioplan
  end

  # POST /comercioplanes
  def create
    # SDK de Mercado Pago
    # require 'mercadopago'
    # Agrega credenciales
    # sdk = Mercadopago::SDK.new('APP_USR-2484239835628727-052600-82909dea192293e8f3598e6660d3a6e8-765237875')
    # Crea un objeto de preferencia
    # preference_data = {
    # items: [
    #   {
    #   title: 'Plan Nuevo',
    #   unit_price: 75,
    #   quantity: 1
    #   }
    # ],
    # back_urls: {
    #   success: 'http://localhost:4200/comerciopanel',
    #   failure: 'http://localhost:4200/comerciopanel',
    #   pending: 'http://localhost:4200/comerciopanel'
    # },
    # }
    # preference_response = sdk.preference.create(preference_data)
    # preference = preference_response[:response]

    # Este valor reemplazará el string "<%= @preference_id %>" en tu HTML
    # @preference_id = preference['id']
    # render json: {preference_id: @preference_id}
    # puts "----------------------------"
    # puts @preference_id


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

  def admin_update
    if @comercioplan.update(comercioplan_params)
      render json: @comercioplan
    else
      render json: @comercioplan.errors.full_messages, status: :unprocessable_entity
    end
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
