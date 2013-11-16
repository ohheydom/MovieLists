require 'test_helper'

class PersonControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

end
