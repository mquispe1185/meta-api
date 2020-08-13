require 'test_helper'

class RubrosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rubro = rubros(:one)
  end

  test "should get index" do
    get rubros_url, as: :json
    assert_response :success
  end

  test "should create rubro" do
    assert_difference('Rubro.count') do
      post rubros_url, params: { rubro: { activo: @rubro.activo, descripcion: @rubro.descripcion } }, as: :json
    end

    assert_response 201
  end

  test "should show rubro" do
    get rubro_url(@rubro), as: :json
    assert_response :success
  end

  test "should update rubro" do
    patch rubro_url(@rubro), params: { rubro: { activo: @rubro.activo, descripcion: @rubro.descripcion } }, as: :json
    assert_response 200
  end

  test "should destroy rubro" do
    assert_difference('Rubro.count', -1) do
      delete rubro_url(@rubro), as: :json
    end

    assert_response 204
  end
end
