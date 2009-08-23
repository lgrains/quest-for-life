class SurveyGroupsController < ApplicationController
  before_filter :authenticate
  make_resourceful do
    actions :all
    response_for :create, :update, :destroy do |format|
      format.html { redirect_to current_user }
    end
  end

  def build_object
    @current_object = current_model.new(object_parameters)
    @current_object.user = current_user
    return @current_object
  end

  def current_object
    @current_object ||= current_user.survey_groups.find(params[:id])
  end

  def current_objects
    @survey_groups ||= current_user.survey_groups.paginate(:page => params[:page], :per_page => 20)
  end
  private
end
