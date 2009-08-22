# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Clearance::Authentication

  helper :all # include all helpers, all the time

  alias_method :logged_in?, :signed_in?
  helper_method :logged_in?

  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
end
