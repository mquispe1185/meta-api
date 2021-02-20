class ComerciosController < ApplicationController
  before_action :set_comercio, only: [:show, :update, :destroy,:set_foto]
  before_action :authenticate_usuario!, only:[:create,:set_foto,:mis_comercios]
  # GET /comercios
  def index
    @comercios = Comercio.where(activo: true).order(:nombre)
    render json: @comercios
  end

  def index_inicio
    @comercios = Comercio.where(activo: true, habilitado: true).order(:nombre).limit(9)
    render json: @comercios
  end

  def mis_comercios
    @comercios = current_usuario.comercios.where(activo: true).order(:nombre)
    render json: @comercios
  end

  def vermas
    @comercios = Comercio.where(activo: true, habilitado: true).order(:nombre).limit(9).offset(params[:n])
    render json: @comercios
  end

  def busqueda
    @comercios = Comercio.search(params[:term])
    render json: @comercios
  end

  def busqueda_rubro
    @comercios = Comercio.searchrubro(params[:term])
    render json: @comercios
  end

  # GET /comercios/1
  def show
    render json: @comercio
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


  # DELETE /comercios/1
  def destroy
    @comercio.update(activo: false)
    @comercio.promociones.update(activo: false)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comercio
      @comercio = Comercio.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comercio_params
      params.require(:comercio).permit(:nombre, :domicilio, :telefono, :celular, :web,:rubro_id, :tipo_servicio,:visitas,
        :facebook, :instagram, :twitter, :latitud, :longitud, :email, :provincia_id, :departamento_id, :localidad_id,:estado,
        :descripcion, :usuario_id, :entrega, :activo,:foto,:tags,:habilitado,:envio)
    end
end
