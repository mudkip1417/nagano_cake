require "test_helper"

class Public::CostomersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_costomers_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_costomers_edit_url
    assert_response :success
  end

  test "should get unsubscribe" do
    get public_costomers_unsubscribe_url
    assert_response :success
  end
end
