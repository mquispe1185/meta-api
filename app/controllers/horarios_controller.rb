class HorariosController < ApplicationController
  before_action :set_horario, only: [:show, :update, :destroy]
#  before_action :authenticate_usuario!, only:[:create]
  # GET /horarios
  def index
    @horarios = Horario.all
    render json: @horarios
  end

  # GET /horarios/1
  def show
    render json: @horario
  end

  # POST /horarios
  def create
    datos = horarios_params[:horarios]
    comercio = Comercio.find(datos[0][:comercio_id])
    datos.each do |horario|
    Horario.create(horario)
    end
    @horarios = comercio.horarios.order(:dia)
    render json: @horarios
  end

  # PATCH/PUT /horarios/1
  def update
    if @horario.update(horario_params)
      render json: @horario
    else
      render json: @horario.errors, status: :unprocessable_entity
    end
  end

  # DELETE /horarios/1
  def destroy
    comercio = Comercio.find(@horario.comercio_id)
    @horario.destroy
    @horarios = comercio.horarios.order(:dia)
    render json: @horarios
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_horario
      @horario = Horario.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def horario_params
      params.require(:horario).permit(:dia, :desde, :hasta, :comercio_id)
    end

    def horarios_params
      params.permit(horarios: [:id,:dia, :desde, :hasta, :comercio_id])
    end
end
