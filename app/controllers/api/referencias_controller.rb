class Api::ReferenciasController < ApplicationController
  before_action :set_referencia, only: [:show, :update, :destroy]
  before_action :authenticate_usuario!, only:[:create]
  # GET /referencias
  def index
    @referencias = Referencia.where(comercio_id: params[:comercio_id])

    render json: @referencias
  end

  # GET /referencias/1
  def show
    render json: @referencia
  end

  # POST /referencias
  def create
    @referencia = Referencia.new(referencia_params)
    @referencia.usuario_id = current_usuario.id
    
    if @referencia.save
      render json: @referencia, status: :created
    else
      render json: @referencia.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /referencias/1
  def update
    if @referencia.update(referencia_params)
      render json: @referencia
    else
      render json: @referencia.errors, status: :unprocessable_entity
    end
  end

  # DELETE /referencias/1
  def destroy
    @referencia.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_referencia
      @referencia = Referencia.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def referencia_params
      params.require(:referencia).permit(:cuerpo, :usuario_id,:comercio_id, :puntaje, :activo)
    end
end
