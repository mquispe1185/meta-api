class ProvinciasController < ApplicationController
  before_action :set_provincia, only: [:show, :update, :destroy]

  # GET /provincias
  def index
    @provincias = Provincia.all

    render json: @provincias
  end

  # GET /provincias/1
  def show
    render json: @provincia
  end

  # POST /provincias
  def create
    @provincia = Provincia.new(provincia_params)

    if @provincia.save
      render json: @provincia, status: :created, location: @provincia
    else
      render json: @provincia.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /provincias/1
  def update
    if @provincia.update(provincia_params)
      render json: @provincia
    else
      render json: @provincia.errors, status: :unprocessable_entity
    end
  end

  # DELETE /provincias/1
  def destroy
    @provincia.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provincia
      @provincia = Provincia.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def provincia_params
      params.require(:provincia).permit(:nombre, :activo)
    end
end
