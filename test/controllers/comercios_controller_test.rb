require 'test_helper'

class ComerciosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comercio = comercios(:one)
  end

  test "should get index" do
    get comercios_url, as: :json
    assert_response :success
  end

  test "should create comercio" do
    assert_difference('Comercio.count') do
      post comercios_url, params: { comercio: { activo: @comercio.activo, celular: @comercio.celular, departamento_id: @comercio.departamento_id, descripcion: @comercio.descripcion, domicilio: @comercio.domicilio, email: @comercio.email, entrega: @comercio.entrega, facebook: @comercio.facebook, horario_desde: @comercio.horario_desde, horario_hasta: @comercio.horario_hasta, instagram: @comercio.instagram, latitud: @comercio.latitud, localidad_id: @comercio.localidad_id, longitud: @comercio.longitud, nombre: @comercio.nombre, provincia_id: @comercio.provincia_id, telefono: @comercio.telefono, twitter: @comercio.twitter, usuario_id: @comercio.usuario_id, web: @comercio.web } }, as: :json
    end

    assert_response 201
  end

  test "should show comercio" do
    get comercio_url(@comercio), as: :json
    assert_response :success
  end

  test "should update comercio" do
    patch comercio_url(@comercio), params: { comercio: { activo: @comercio.activo, celular: @comercio.celular, departamento_id: @comercio.departamento_id, descripcion: @comercio.descripcion, domicilio: @comercio.domicilio, email: @comercio.email, entrega: @comercio.entrega, facebook: @comercio.facebook, horario_desde: @comercio.horario_desde, horario_hasta: @comercio.horario_hasta, instagram: @comercio.instagram, latitud: @comercio.latitud, localidad_id: @comercio.localidad_id, longitud: @comercio.longitud, nombre: @comercio.nombre, provincia_id: @comercio.provincia_id, telefono: @comercio.telefono, twitter: @comercio.twitter, usuario_id: @comercio.usuario_id, web: @comercio.web } }, as: :json
    assert_response 200
  end

  test "should destroy comercio" do
    assert_difference('Comercio.count', -1) do
      delete comercio_url(@comercio), as: :json
    end

    assert_response 204
  end
end
