class SurveyGroupsController < ApplicationController
  before_filter :authenticate
  make_resourceful do
    actions :all
  end

  def build_object
    @current_object = current_model.new((object_parameters||{}).merge(:user_id => current_user))
  end

  def current_object
    @current_object ||= current_user.survey_groups.find(params[:id])
  end

  def current_objects
    @survey_groups = current_model.paginate(:page => params[:page], :per_page => 20)
  end
  private
end
