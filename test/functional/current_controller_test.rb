require 'test_helper'

class CurrentControllerTest < ActionController::TestCase
  test "should get ip" do
    get :ip
    assert_response :success
  end

end
