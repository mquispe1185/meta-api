class RolesController < ApplicationController
  before_action :set_rol, only: [:show, :update, :destroy]

  # GET /roles
  def index
    @roles = Rol.all

    render json: @roles
  end

  # GET /roles/1
  def show
    render json: @rol
  end

  # POST /roles
  def create
    @rol = Rol.new(rol_params)

    if @rol.save
      render json: @rol, status: :created, location: @rol
    else
      render json: @rol.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /roles/1
  def update
    if @rol.update(rol_params)
      render json: @rol
    else
      render json: @rol.errors, status: :unprocessable_entity
    end
  end

  # DELETE /roles/1
  def destroy
    @rol.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rol
      @rol = Rol.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def rol_params
      params.require(:rol).permit(:descripcion)
    end
end
