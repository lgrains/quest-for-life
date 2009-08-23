class SurveysController < ApplicationController
  before_filter :find_parameter, :only => :edit
  before_filter :only_show_if_completed, :only => :show
  before_filter :authorize, :only => [:edit, :update]
  
  make_resourceful do
    actions :new, :create, :show, :index, :edit, :update
    belongs_to :survey_group

    before:index do
      @parameter = 'n' 
    end

    after :create do
      # store survey id in the user's session, which authorizes them to edit/update
      session[:survey_id] = current_object.id
    end

    response_for :create do |format|
      format.html do
        redirect_to edit_survey_path(current_object)
      end
    end
    response_for :update do |format|
      format.html do
        if params[:demographics].present?
          # just asked for demographic data, show results
          redirect_to(current_object)
        else        
          n = next_parameter
          if n
            redirect_to survey_parameter_path(current_object, n)
          else
            # no more parameters... need to ask for demographic data
            redirect_to survey_demographics_path(current_object)
          end
        end
      end
    end
  end

  def current_objects
    @current_objects ||= current_model.n_not_null #.paginate(:per_page => 20, :page => params[:page])
  end
  
  def current_object
    @current_object ||= current_model.find_by_slug(params[:id]) if params[:id].present?
    return @current_object
  end

  private
  def next_parameter
    current = params[:survey].keys.map{|k| k.sub(/_rational_id$/, '')}.find{|k| Survey.parameter_columns.include? k.to_sym }
    Survey.next_parameter(current)
  end
  def find_parameter
    @parameter = params[:parameter] || Survey.parameter_columns.first.to_s
  end
  
  def authorize
    return if current_object.nil?
    
    unless current_object.id == session[:survey_id]
      if current_object.completed?
        redirect_to [parent_object, current_object].flatten # show survey
      else
        redirect_to parent? ? survey_group_surveys_path : surveys_path
      end
    end
  end
  
  def only_show_if_completed
    redirect_to ( parent? ? survey_group_surveys_path : surveys_path) unless current_object.completed?
  end
end
