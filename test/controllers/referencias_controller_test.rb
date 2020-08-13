require 'test_helper'

class ReferenciasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @referencia = referencias(:one)
  end

  test "should get index" do
    get referencias_url, as: :json
    assert_response :success
  end

  test "should create referencia" do
    assert_difference('Referencia.count') do
      post referencias_url, params: { referencia: { activo: @referencia.activo, cuerpo: @referencia.cuerpo, puntaje: @referencia.puntaje, usuario_id: @referencia.usuario_id } }, as: :json
    end

    assert_response 201
  end

  test "should show referencia" do
    get referencia_url(@referencia), as: :json
    assert_response :success
  end

  test "should update referencia" do
    patch referencia_url(@referencia), params: { referencia: { activo: @referencia.activo, cuerpo: @referencia.cuerpo, puntaje: @referencia.puntaje, usuario_id: @referencia.usuario_id } }, as: :json
    assert_response 200
  end

  test "should destroy referencia" do
    assert_difference('Referencia.count', -1) do
      delete referencia_url(@referencia), as: :json
    end

    assert_response 204
  end
end
