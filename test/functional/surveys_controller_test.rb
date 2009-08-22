require File.dirname(__FILE__) + '/../test_helper'
class SurveysControllerTest < ActionController::TestCase
  test "new" do
    get :new
    assert_response :ok
    assert_not_nil assigns(:current_object)
  end
  
  test "create" do
    post :create, :survey => {}

    assert_redirected_to edit_survey_path(assigns(:current_object))
    assert_not_nil assigns(:current_object)
    assert_equal assigns(:current_object).id, session[:survey_id]
  end

  test "show incomplete survey" do
    survey = Factory.create(:survey)
    get :show, :id => survey.slug
    assert_redirected_to surveys_path
  end

  test "show completed survey" do    
    survey = Factory.create(:completed_survey)
    get :show, :id => survey.slug

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
