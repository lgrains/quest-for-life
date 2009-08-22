require 'test_helper'

class SurveysControllerTest < ActionController::TestCase
  test "new" do
    get :new
    assert_response :ok
    assert_not_nil assigns(:current_object)
  end
  
  # test "create" do
  #   post :create, 
  #   
  # end
end
