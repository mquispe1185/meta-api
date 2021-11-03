class Api::ComercioplanesController < ApplicationController
  before_action :set_comercioplan, only: [:show, :update, :destroy, :admin_update]
  before_action :authenticate_usuario!, only:[:misplanes,:index]
  
  # GET /comercioplanes
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
    @comercioplan = current_usuario.comercioplanes.new(comercioplan_params)
    comercio = @comercioplan.comercio
    @comercioplan.servicio_anterior_id = comercio.tipo_servicio_id
    if @comercioplan.save
      comercio.update(estado: :cambio_pendiente)
      render json: comercio, status: :created, serializer: ComercioSerializer
    else
      render json: @comercioplan.errors.full_messages, status: :unprocessable_entity
    end
  end

  def solicitud_mp
    # SDK de Mercado Pago
    require 'mercadopago'
    # Agrega credenciales
    sdk = Mercadopago::SDK.new(Rails.application.credentials.mp_key_dev)
    # Crea un objeto de preferencia
    preference_data = {
    items: [
      {
      title: params[:tipo_servicio][:nombre],
      description: 'NUEVA DESCRIPCION',
      unit_price: params[:tipo_servicio][:importe].to_i,
      quantity: params[:meses],
      id:params[:comercio_id],
      category_id: params[:tipo_servicio][:id],
      }
    ],
    back_urls: {
      success: 'http://localhost:4200/comerciopanel',
      pending: 'http://localhost:4200/comerciopanel',

      #success: 'https://www.metacerca.com.ar/comerciopanel',
      failure: 'https://www.metacerca.com.ar/comerciopanel',
      #pending: 'https://www.metacerca.com.ar/comerciopanel'
    },
    # auto_return: 'approved'
    }
    #Respuesta del servidor mercado pago
    preference_response = sdk.preference.create(preference_data)
    preference = preference_response[:response]
    
    # Este valor reemplazará el string "<%= @preference_id %>" en tu HTML
    @preference_id = preference['id']
    render json: {preference_id: @preference_id}
  end
  
  def alta_plan_mp
    require 'net/http'
    require 'uri'
    
    uri = URI("https://api.mercadopago.com/v1/payments/#{params[:payment_id]}")
    req = Net::HTTP::Get.new(uri)
    req['Authorization']= "Bearer #{Rails.application.credentials.mp_key_dev}"
    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) {|http|
      http.request(req)
    }
    data = JSON.parse(res.body)

    # Cargar los valores que necesitamos para Crear el ComercioPlan del Comercio.
    comercio = Comercio.find(data['additional_info']['items'][0]['id'].to_i)
    tipo_servicio_id = (data['additional_info']['items'][0]['category_id'])
    importe = (data['transaction_details']['total_paid_amount'])
    meses = (data['additional_info']['items'][0]['quantity'])

    comercioplan = Comercioplan.new(comercio_id: comercio.id, tipo_servicio_id: tipo_servicio_id,
                  formapago_id: 4, importe: importe, usuario_id:comercio.usuario_id,
                  servicio_anterior_id: comercio.tipo_servicio_id, meses: meses, payment_id: params[:payment_id])


    if comercioplan.save
      comercio.update(estado: :cambio_pendiente)
      render json: { status: :created }
    else
      render json: comercioplan.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comercioplanes/1
  #Es solo utilizado por admin para cambiar el estado de COMERCIOPLAN solicitado.
  def update
    if @comercioplan.update(comercioplan_params)
     
      comercio = @comercioplan.comercio
      case @comercioplan.read_attribute_before_type_cast(:estado)
      when Comercioplan::PENDIENTE 
        # comercio.update(estado: Comercio::DEFAULT,tipo_servicio_id: @comercioplan.servicio_anterior_id)
        comercio.update(estado: :cambio_pendiente, tipo_servicio_id: @comercioplan.servicio_anterior_id)
        @comercioplan.update(desde: nil, hasta: nil)
      when Comercioplan::APROBADO
        # comercio.update(estado: Comercio::DEFAULT,tipo_servicio_id: @comercioplan.tipo_servicio_id)
        comercio.update(estado: :default, tipo_servicio_id: @comercioplan.tipo_servicio_id)
        @comercioplan.update(estado: :aprobado, pagado: :true, desde: Date.today, hasta: Date.today + @comercioplan.meses.months)
      when Comercioplan::VENCIDO
        @comercioplan.update(estado: :vencido)
        nuevo_cp = ComercioPlan.create(servicio_anterior_id: @comercioplan.tipo_servicio_id, tipo_servicio_id: TipoServicio::GRATUITO, 
                        desde: Date.today, hasta: Date.today + 1.months, pagado: true, formapago_id: Formapago::GRATUITO)
        comercio.update(estado: :default, tipo_servicio_id: nuevo_cp.tipo_servicio_id)

      when Comercioplan::RECHAZADO
        comercio.update(estado: :default,tipo_servicio_id: @comercioplan.servicio_anterior_id)
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

  # utilizado por el admin para actualizar el COMERCIOPLAN de un comercio.
  def admin_update
    if @comercioplan.update(comercioplan_params)
      render json: @comercioplan
    else
      render json: @comercioplan.errors.full_messages, status: :unprocessable_entity
    end
  end

  def review_planes
    comercioplanes = ComercioPlan.where('hasta <= ?', Date.yesteday)

    @comercioplanes===.each do |cp|
      @comercioplan.update(estado: :vencido)
      nuevo_cp = ComercioPlan.create(servicio_anterior_id: @comercioplan.tipo_servicio_id, tipo_servicio_id: TipoServicio::GRATUITO, 
                                    desde: Date.today, hasta: Date.today + 1.months, pagado: true, formapago_id: Formapago::GRATUITO)
      comercio.update(estado: :default, tipo_servicio_id: nuevo_cp.tipo_servicio_id)
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
