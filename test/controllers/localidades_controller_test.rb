require 'test_helper'

class LocalidadesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @localidad = localidades(:one)
  end

  test "should get index" do
    get localidades_url, as: :json
    assert_response :success
  end

  test "should create localidad" do
    assert_difference('Localidad.count') do
      post localidades_url, params: { localidad: { activo: @localidad.activo, departamento_id: @localidad.departamento_id, nombre: @localidad.nombre, provincia_id: @localidad.provincia_id } }, as: :json
    end

    assert_response 201
  end

  test "should show localidad" do
    get localidad_url(@localidad), as: :json
    assert_response :success
  end

  test "should update localidad" do
    patch localidad_url(@localidad), params: { localidad: { activo: @localidad.activo, departamento_id: @localidad.departamento_id, nombre: @localidad.nombre, provincia_id: @localidad.provincia_id } }, as: :json
    assert_response 200
  end

  test "should destroy localidad" do
    assert_difference('Localidad.count', -1) do
      delete localidad_url(@localidad), as: :json
    end

    assert_response 204
  end
end
