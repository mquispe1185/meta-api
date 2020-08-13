class RubrosController < ApplicationController
  before_action :set_rubro, only: [:show, :update, :destroy]

  # GET /rubros
  def index
    @rubros = Rubro.all

    render json: @rubros
  end

  # GET /rubros/1
  def show
    render json: @rubro
  end

  # POST /rubros
  def create
    @rubro = Rubro.new(rubro_params)

    if @rubro.save
      render json: @rubro, status: :created, location: @rubro
    else
      render json: @rubro.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rubros/1
  def update
    if @rubro.update(rubro_params)
      render json: @rubro
    else
      render json: @rubro.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rubros/1
  def destroy
    @rubro.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rubro
      @rubro = Rubro.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def rubro_params
      params.require(:rubro).permit(:descripcion, :activo)
    end
end
