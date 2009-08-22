class SurveysController < ApplicationController
  before_filter :find_parameter, :only => :edit
  
  make_resourceful do
    actions :new, :create, :show, :index, :edit, :update

    response_for :create do |format|
      format.html do
        redirect_to edit_survey_path(current_object)
      end
    end
    response_for :update do |format|
      format.html do
        if (n = next_parameter) #not a bug, intended assignment!
          redirect_to survey_parameter_path(current_object, n)
        else
          redirect_to current_object
        end
      end
    end
  end

  def current_objects
    current_model.paginate(:per_page => 20, :page => params[:page])
  end

  private
  def next_parameter
    current = params[:survey].keys.find{|k| Survey.parameter_columns.include? k.to_sym }
    Survey.next_parameter(current)
  end
  def find_parameter
    @parameter = params[:parameter] || Survey.parameter_columns.first.to_s
  end
end
