class FormapagosController < ApplicationController
  before_action :set_formapago, only: [:show, :update, :destroy]

  # GET /formapagos
  def index
    @formapagos = Formapago.all

    render json: @formapagos
  end

  # GET /formapagos/1
  def show
    render json: @formapago
  end

  # POST /formapagos
  def create
    @formapago = Formapago.new(formapago_params)

    if @formapago.save
      render json: @formapago, status: :created, location: @formapago
    else
      render json: @formapago.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /formapagos/1
  def update
    if @formapago.update(formapago_params)
      render json: @formapago
    else
      render json: @formapago.errors, status: :unprocessable_entity
    end
  end

  # DELETE /formapagos/1
  def destroy
    @formapago.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_formapago
      @formapago = Formapago.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def formapago_params
      params.require(:formapago).permit(:descripcion)
    end
end
