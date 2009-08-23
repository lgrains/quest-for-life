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
