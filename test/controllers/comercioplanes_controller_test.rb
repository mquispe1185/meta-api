require 'test_helper'

class ComercioplanesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comercioplan = comercioplanes(:one)
  end

  test "should get index" do
    get comercioplanes_url, as: :json
    assert_response :success
  end

  test "should create comercioplan" do
    assert_difference('Comercioplan.count') do
      post comercioplanes_url, params: { comercioplan: { comercio_id: @comercioplan.comercio_id, desde: @comercioplan.desde, estado: @comercioplan.estado, formapago_id: @comercioplan.formapago_id, hasta: @comercioplan.hasta, importe: @comercioplan.importe, tipo_servicio_id: @comercioplan.tipo_servicio_id } }, as: :json
    end

    assert_response 201
  end

  test "should show comercioplan" do
    get comercioplan_url(@comercioplan), as: :json
    assert_response :success
  end

  test "should update comercioplan" do
    patch comercioplan_url(@comercioplan), params: { comercioplan: { comercio_id: @comercioplan.comercio_id, desde: @comercioplan.desde, estado: @comercioplan.estado, formapago_id: @comercioplan.formapago_id, hasta: @comercioplan.hasta, importe: @comercioplan.importe, tipo_servicio_id: @comercioplan.tipo_servicio_id } }, as: :json
    assert_response 200
  end

  test "should destroy comercioplan" do
    assert_difference('Comercioplan.count', -1) do
      delete comercioplan_url(@comercioplan), as: :json
    end

    assert_response 204
  end
end
