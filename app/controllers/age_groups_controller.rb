class AgeGroupsController < ApplicationController
  before_filter :authenticate, :verify_admin

  make_resourceful do
    actions :all
    
    response_for :create, :update, :destroy do |format|
      format.html { redirect_to age_groups_path }
    end
    
  end  
  
end
