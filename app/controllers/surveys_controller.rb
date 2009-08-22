class SurveysController < ApplicationController
  
  make_resourceful do
    actions :new, :create, :show, :index #, :edit, :update
  end

  def current_objects
    current_model.paginate(:per_page => 20, :page => params[:page])
  end
end
