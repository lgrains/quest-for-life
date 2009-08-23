require File.dirname(__FILE__) + '/../test_helper'

class SurveyGroupsControllerTest < ActionController::TestCase
  setup :login
  test "new" do
    get :new
    assert_response :ok
    assert_not_nil assigns(:current_object)
  end
  
  test "create" do
    post :create, :survey_group => {:group_name => 'test group', :age_group => Factory(:age_group)}

    assert_redirected_to assigns(:current_object).user
    assert_not_nil assigns(:current_object)
    assert_equal @user, assigns(:current_object).user
    assert_equal 'test group', assigns(:current_object).group_name
  end

  test "show group belonging to current user" do    
    survey_group = Factory.create(:survey_group, :user => @user)
    get :show, :id => survey_group

    assert_response :ok
    assert_equal survey_group, assigns(:current_object)
  end

  test "edit a survey group that belongs to the current user" do
    survey_group = Factory.create(:survey_group, :user => @user)
    get :edit, :id => survey_group

    assert_response :ok
  end

  test "edit a survey group that does not belong to to the current user" do
    survey_group = Factory.create(:survey_group, :user => Factory(:user))
    assert survey_group.user != @user
    get :edit, :id => survey_group

    assert_response :not_found
  end

  test "update a survey that belongs to the current user" do
    survey_group = Factory.create(:survey_group)
    put :update, :id => survey_group, :survey_group => {}

    assert_redirected_to survey_group.user, "should have redirected to view"
  end

  test "index" do
    survey_groups = [Factory(:survey_group), Factory(:survey_group)]
    get :index

    assert_response :ok
    assert_same_elements survey_groups, assigns(:survey_groups)
  end

  private
  def login
    @user ||= Factory(:email_confirmed_user)
    @controller.stubs(:current_user => @user)
  end
end
