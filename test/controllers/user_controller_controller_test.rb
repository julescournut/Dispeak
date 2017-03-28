require 'test_helper'

class UserControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get get" do
    get user_controller_get_url
    assert_response :success
  end

  test "should get save" do
    get user_controller_save_url
    assert_response :success
  end

end
