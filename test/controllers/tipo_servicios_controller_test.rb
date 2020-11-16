require 'test_helper'

class TipoServiciosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tipo_servicio = tipo_servicios(:one)
  end

  test "should get index" do
    get tipo_servicios_url, as: :json
    assert_response :success
  end

  test "should create tipo_servicio" do
    assert_difference('TipoServicio.count') do
      post tipo_servicios_url, params: { tipo_servicio: { descripcion: @tipo_servicio.descripcion, importe: @tipo_servicio.importe, nombre: @tipo_servicio.nombre } }, as: :json
    end

    assert_response 201
  end

  test "should show tipo_servicio" do
    get tipo_servicio_url(@tipo_servicio), as: :json
    assert_response :success
  end

  test "should update tipo_servicio" do
    patch tipo_servicio_url(@tipo_servicio), params: { tipo_servicio: { descripcion: @tipo_servicio.descripcion, importe: @tipo_servicio.importe, nombre: @tipo_servicio.nombre } }, as: :json
    assert_response 200
  end

  test "should destroy tipo_servicio" do
    assert_difference('TipoServicio.count', -1) do
      delete tipo_servicio_url(@tipo_servicio), as: :json
    end

    assert_response 204
  end
end
