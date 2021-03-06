class Api::ComerciosController < ApplicationController
  before_action :set_comercio, only: [:show, :update, :destroy,:set_foto]
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

  def set_foto
    @comercio.foto.purge
    @comercio.foto.attach(params[:foto])
    if @comercio.foto.attached?
        @comercio.update(url_foto: "https://s3.us-east-2.amazonaws.com/meta.app/#{@comercio.foto.key}")
    end
    @comercios = current_usuario.comercios.where(activo: true).order(:nombre)
    render json: @comercios
    #render json: {url_logo: "https://s3.sa-east-1.amazonaws.com/api.eira/#{@institucion.avatar.key}"}
  end


  # POST /comercios
  def create
    @comercio = Comercio.new(comercio_params)
    @comercio.usuario_id = current_usuario.id
    @comercio.tipo_servicio_id = 1
    if @comercio.save
     #@comercios = current_usuario.comercios.where(activo: true).order(:nombre)
    render json: @comercio
    else
      puts @comercio.errors.full_messages
      render json: @comercio.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comercios/1
  def update
    if @comercio.update(comercio_params)
      if current_usuario.rol_id == 1
        @comercios = Comercio.where(activo: true).order(:nombre)
      else
      @comercios = current_usuario.comercios.where(activo: true).order(:nombre)
      end
      render json: @comercios
    else
      render json: @comercio.errors, status: :unprocessable_entity
    end
  end

  def habilitar
    @comercio = Comercio.find(params[:comercio_id])
    @comercio.habilitado = !@comercio.habilitado
    if @comercio.habilitado
        @comercio.usuario.update(rol_id: 2)
    end
    if @comercio.save
      @comercios = Comercio.where(activo: true).order(:nombre)
      render json: @comercios
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
        :visitas_face,:visitas_ig,:visitas_web)
    end
end
