require "application_system_test_case"

class BundlesTest < ApplicationSystemTestCase
  setup do
    @bundle = bundles(:one)
  end

  test "visiting the index" do
    visit bundles_url
    assert_selector "h1", text: "Bundles"
  end

  test "should create bundle" do
    visit bundles_url
    click_on "New bundle"

    fill_in "Code", with: @bundle.code
    fill_in "Price", with: @bundle.price
    fill_in "Quantity", with: @bundle.quantity
    click_on "Create Bundle"

    assert_text "Bundle was successfully created"
    click_on "Back"
  end

  test "should update Bundle" do
    visit bundle_url(@bundle)
    click_on "Edit this bundle", match: :first

    fill_in "Code", with: @bundle.code
    fill_in "Price", with: @bundle.price
    fill_in "Quantity", with: @bundle.quantity
    click_on "Update Bundle"

    assert_text "Bundle was successfully updated"
    click_on "Back"
  end

  test "should destroy Bundle" do
    visit bundle_url(@bundle)
    click_on "Destroy this bundle", match: :first

    assert_text "Bundle was successfully destroyed"
  end
end
