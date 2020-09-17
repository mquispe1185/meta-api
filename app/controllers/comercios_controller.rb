class ComerciosController < ApplicationController
  before_action :set_comercio, only: [:show, :update, :destroy,:set_foto]
  before_action :authenticate_usuario!, only:[:create,:set_foto,:mis_comercios]
  # GET /comercios
  def index
    @comercios = Comercio.all
    render json: @comercios
  end

  def mis_comercios
    @comercios = current_usuario.comercios
    render json: @comercios
  end

  def busqueda
    @comercios = Comercio.search(params[:term])
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
        @comercio.update(url_foto: "https://metaapp123.s3.us-east-2.amazonaws.com/#{@comercio.foto.key}")
   
    end
    @comercios = current_usuario.comercios
    render json: @comercios
    #render json: {url_logo: "https://s3.sa-east-1.amazonaws.com/api.eira/#{@institucion.avatar.key}"}
  end


  # POST /comercios
  def create

    @comercio = Comercio.new(comercio_params)
    @comercio.usuario_id = current_usuario.id
    if @comercio.save
     @comercios = current_usuario.comercios.where(activo: true)
    render json: @comercios
    else
      puts @comercio.errors.full_messages
      render json: @comercio.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comercios/1
  def update
    if @comercio.update(comercio_params)
      @comercios = current_usuario.comercios.where(activo: true)
      render json: @comercios
    else
      render json: @comercio.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comercios/1
  def destroy
    @comercio.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comercio
      @comercio = Comercio.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comercio_params
      params.require(:comercio).permit(:nombre, :domicilio, :telefono, :celular, :web,:rubro_id,
        :facebook, :instagram, :twitter, :latitud, :longitud, :email, :provincia_id, :departamento_id, :localidad_id, 
        :descripcion, :usuario_id, :entrega, :activo,:foto,:tags)
    end
end
