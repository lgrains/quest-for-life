require File.dirname(__FILE__) + '/../test_helper'
class SurveysControllerTest < ActionController::TestCase
  test "new" do
    get :new
    assert_response :ok
    assert_not_nil assigns(:current_object)
  end
  
  test "create" do
    post :create, :survey => {}

    assert_redirected_to assigns(:current_object)
    assert assigns(:current_object).present?
    assert !assigns(:current_object).new_record?
  end

  test "show" do
    survey = Factory.create(:survey)
    get :show, :id => survey

    assert_response :ok
    assert_equal survey, assigns(:current_object)
  end

  test "index" do
    Survey.delete_all
    surveys = [Factory(:survey), Factory(:survey)]
    get :index

    assert_response :ok
    assert_same_elements surveys, assigns(:surveys)
  end
end
