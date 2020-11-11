require 'test_helper'

class FormapagosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @formapago = formapagos(:one)
  end

  test "should get index" do
    get formapagos_url, as: :json
    assert_response :success
  end

  test "should create formapago" do
    assert_difference('Formapago.count') do
      post formapagos_url, params: { formapago: { descripcion: @formapago.descripcion } }, as: :json
    end

    assert_response 201
  end

  test "should show formapago" do
    get formapago_url(@formapago), as: :json
    assert_response :success
  end

  test "should update formapago" do
    patch formapago_url(@formapago), params: { formapago: { descripcion: @formapago.descripcion } }, as: :json
    assert_response 200
  end

  test "should destroy formapago" do
    assert_difference('Formapago.count', -1) do
      delete formapago_url(@formapago), as: :json
    end

    assert_response 204
  end
end
