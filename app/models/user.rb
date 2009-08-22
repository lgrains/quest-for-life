class User < ActiveRecord::Base
  include Clearance::User
  has_many :survey_groups
  
  attr_accessible :identity_url
end
