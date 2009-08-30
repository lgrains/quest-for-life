# Copyright (c) 2009 Steven Hammond, Cris Necochea, Joe Lind, Jeremy Weiskotten
# 
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.

class SessionsController < Clearance::SessionsController
  
  def create
    if using_open_id?
      authenticate_with_openid
    else
      # let Clearance handle authentication
      super
    end
  end

  
  private
  
  def url_after_create
    #send the user to his/her dashboard
    current_user
  end
  def authenticate_with_openid
    @openid_url = params[:openid_url]
    
    # Pass optional :required and :optional keys to specify what sreg fields 
    # you want. Be sure to yield registration, a third argument in the block.
    authenticate_with_open_id(@openid_url, :optional => [:email]) do |result, identity_url, reg|
      if result.successful?
        @user = User.find_by_identity_url(identity_url)

        if @user.nil?
          if reg['email'].present?
            # create account for user
            @user = User.new
            @user.email = reg['email']
            @user.identity_url = identity_url
            @user.encrypted_password = 'no password' # hack around validation
            @user.save
          else
            # didn't get email from openid, need to prompt for it
            redirect_to new_user_path(:identity_url => identity_url)
            return
          end          
        end

        sign_user_in(@user)
        redirect_back_or url_after_create
      else
        deny_access(result.message || 
          "Sorry, could not authenticate #{identity_url}")
      end
    end
    
  end
end
