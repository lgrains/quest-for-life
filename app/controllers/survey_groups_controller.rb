class SurveyGroupsController < ApplicationController
  before_filter :authenticate
  before_filter :verify_ownership :only => [:update, :edit]
  make_resourceful do
    actions :all
  end

  def build_object
    @current_object = current_model.new((object_parameters||{}).merge(:user_id => current_user))
  end

  private
  def verify_ownership
    return false
  end
end
