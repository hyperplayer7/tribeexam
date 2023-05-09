require "test_helper"

class BundlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bundle = bundles(:one)
  end

  test "should get index" do
    get bundles_url
    assert_response :success
  end

  test "should get new" do
    get new_bundle_url
    assert_response :success
  end

  test "should create bundle" do
    assert_difference("Bundle.count") do
      post bundles_url, params: { bundle: { code: @bundle.code, price: @bundle.price, quantity: @bundle.quantity } }
    end

    assert_redirected_to bundle_url(Bundle.last)
  end

  test "should show bundle" do
    get bundle_url(@bundle)
    assert_response :success
  end

  test "should get edit" do
    get edit_bundle_url(@bundle)
    assert_response :success
  end

  test "should update bundle" do
    patch bundle_url(@bundle), params: { bundle: { code: @bundle.code, price: @bundle.price, quantity: @bundle.quantity } }
    assert_redirected_to bundle_url(@bundle)
  end

  test "should destroy bundle" do
    assert_difference("Bundle.count", -1) do
      delete bundle_url(@bundle)
    end

    assert_redirected_to bundles_url
  end
end
