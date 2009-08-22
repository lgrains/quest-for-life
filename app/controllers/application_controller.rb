# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Clearance::Authentication
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  helper :all # include all helpers, all the time

  alias_method :logged_in?, :signed_in?
  helper_method :logged_in?

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def record_not_found
    render :template => '/error/error_404', :status => 404 , :layout => 'application.html.haml'
  end

  def verify_admin
    redirect_to root_path unless current_user.try(:admin?)
  end
  
end
