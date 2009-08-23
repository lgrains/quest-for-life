class User < ActiveRecord::Base
  include Clearance::User
  has_many :survey_groups
  
  attr_accessible :identity_url, :login
  validates_uniqueness_of :login, :case_sensitive => false, :allow_nil => true
end
