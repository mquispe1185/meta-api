class Api::ComerciosController < ApplicationController
  before_action :set_comercio, only: [:show, :update, :destroy,:set_fotos, :delete_foto]
  before_action :authenticate_usuario!, only:[:create,:set_foto,:mis_comercios]
  # GET /comercios
  def index
    @comercios = Comercio.where(activo: true).order(created_at: :desc)
    render json: @comercios
  end

  def index_inicio
    @comercios = Comercio.where(activo: true, habilitado: true).order(created_at: :desc).limit(9)
    render json: @comercios, each_serializer: ComercioShortSerializer
  end

  def mis_comercios
    @comercios = current_usuario.comercios.where(activo: true).order(:nombre)
    render json: @comercios, each_serializer: MisComerciosSerializer
  end

  def vermas
    @comercios = Comercio.where(activo: true, habilitado: true).order(created_at: :desc).limit(9).offset(params[:n])
    render json: @comercios, each_serializer: ComercioShortSerializer
  end

  def busqueda
    @comercios = Comercio.search(params[:term])
    render json: @comercios, each_serializer: ComercioShortSerializer
  end

  def busqueda_rubro
    @comercios = Comercio.searchrubro(params[:term])
    render json: @comercios, each_serializer: ComercioShortSerializer
  end

  # GET /comercios/1
  def show
    render json: @comercio, serializer: ComercioVisitanteSerializer
  end

  def set_fotos
    @comercio.fotos.attach(params[:fotos])
    @comercio.update(url_foto: "#{ENV['BASE_URL_IMG']}#{@comercio.fotos.first.key}")
    render json: @comercio, serializer: MisComerciosSerializer
  end


  # POST /comercios
  def create
    @comercio = current_usuario.comercios.new(comercio_params)
    @comercio.tipo_servicio_id = TipoServicio::NUEVO
    if @comercio.save
     #@comercios = current_usuario.comercios.where(activo: true).order(:nombre)
    render json: @comercio
    else
      render json: @comercio.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comercios/1
  def update
    if params[:comercio][:url_video].present?
      params[:comercio][:url_video] = params[:comercio][:url_video].sub('https://youtu.be/', '')
    end
    if @comercio.update(comercio_params)
      if current_usuario.rol_id == 1
        render json: @comercio
      else
        render json: @comercio, serializer: MisComerciosSerializer
      end
    else
      render json: @comercio.errors, status: :unprocessable_entity
    end
  end

  def habilitar
    @comercio = Comercio.find(params[:comercio_id])
    @comercio.habilitado = !@comercio.habilitado
    if @comercio.habilitado
        @comercio.usuario.update(rol_id: 2)
        #Solo para el caso que el usuario no realizo el Paso 2 en el Alta de Comercio.
        if (@comercio.plan_nuevo && @comercio.tipo_servicio_id ==  TipoServicio::NUEVO)
          @comercio.plan_nuevo.update(estado: :aprobado, tipo_servicio_id: TipoServicio::GRATUITO)
          @comercio.update(tipo_servicio_id: TipoServicio::GRATUITO)
        end
    end
    if @comercio.save
      render json: @comercio
    else
      render json: @comercio.errors, status: :unprocessable_entity
    end
  end

  def add_visita
    @comercio = Comercio.find(params[:comercio_id])
    @comercio.visitas += 1
    if @comercio.save
      render json: @comercio
    else
      render json: @comercio.errors, status: :unprocessable_entity
    end
  end

  def add_visita_links
    @comercio = Comercio.find(params[:comercio_id])
    
    case params[:link].to_i
    when 1
      @comercio.visitas_face += 1
    when 2
      @comercio.visitas_ig += 1
    when 3
      @comercio.visitas_web += 1
    when 4
      @comercio.visitas_wsp += 1
    end

    if @comercio.save
      render json: @comercio
    else
      render json: @comercio.errors, status: :unprocessable_entity
    end
  end

  def estadistica_links
    @comercio = Comercio.find(params[:comercio_id])
    render json: @comercio, serializer: ComercioEstadisticaSerializer
  end

  def enviar_consulta
    ConsultaMailer.send_consulta(params[:nombre],params[:email],params[:consulta]).deliver_now
  end
  # DELETE /comercios/1
  def destroy
    @comercio.update(activo: false)
    @comercio.promociones.update(activo: false)
    @comercio.comercioplanes.update(activo: false)
  end

  def delete_foto
    foto = ActiveStorage::Attachment.find(params[:foto_id])
    if foto
      foto.purge
      render json: @comercio, serializer: MisComerciosSerializer
    else
      render json: @comercio.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comercio
      @comercio = Comercio.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comercio_params
      params.require(:comercio).permit(:nombre, :domicilio, :telefono, :celular, :web,:rubro_id, :tipo_servicio,:visitas,
        :facebook, :instagram, :facebook_id, :latitud, :longitud, :email, :provincia_id, :departamento_id, :localidad_id,:estado,
        :descripcion, :usuario_id, :entrega, :activo,:foto,:tags,:habilitado,:envio,:es_fanpage,
        :visitas_face,:visitas_ig,:visitas_web, :url_video)
    end
end
