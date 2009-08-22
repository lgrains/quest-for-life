class User < ActiveRecord::Base
  include Clearance::User
  
  attr_accessible :identity_url
end
