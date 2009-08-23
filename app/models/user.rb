class User < ActiveRecord::Base
  include Clearance::User
  has_many :survey_groups
  
  attr_accessible :identity_url, :login
  validates_uniqueness_of :login, :case_sensitive => false, :allow_nil => true
  def self.teachers
    scoped(:include =>{:survey_groups => :surveys}).admin_is(false).email_confirmed_is(true)
  end

  def to_param
    (self.email_confirmed? && self.login) || self.id
  end
  
end
