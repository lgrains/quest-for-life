require 'test_helper'

class SurveysControllerTest < ActionController::TestCase
  test "new" do
    get :new
    assert_response :ok
  end
end
