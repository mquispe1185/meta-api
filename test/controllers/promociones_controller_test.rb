require 'test_helper'

class PromocionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @promocion = promociones(:one)
  end

  test "should get index" do
    get promociones_url, as: :json
    assert_response :success
  end

  test "should create promocion" do
    assert_difference('Promocion.count') do
      post promociones_url, params: { promocion: { comercio_id_id: @promocion.comercio_id_id, descripcion: @promocion.descripcion, desde: @promocion.desde, duracion: @promocion.duracion, estado: @promocion.estado, hasta: @promocion.hasta, prioridad: @promocion.prioridad, titulo: @promocion.titulo, usuario_id_id: @promocion.usuario_id_id, vencido: @promocion.vencido } }, as: :json
    end

    assert_response 201
  end

  test "should show promocion" do
    get promocion_url(@promocion), as: :json
    assert_response :success
  end

  test "should update promocion" do
    patch promocion_url(@promocion), params: { promocion: { comercio_id_id: @promocion.comercio_id_id, descripcion: @promocion.descripcion, desde: @promocion.desde, duracion: @promocion.duracion, estado: @promocion.estado, hasta: @promocion.hasta, prioridad: @promocion.prioridad, titulo: @promocion.titulo, usuario_id_id: @promocion.usuario_id_id, vencido: @promocion.vencido } }, as: :json
    assert_response 200
  end

  test "should destroy promocion" do
    assert_difference('Promocion.count', -1) do
      delete promocion_url(@promocion), as: :json
    end

    assert_response 204
  end
end
