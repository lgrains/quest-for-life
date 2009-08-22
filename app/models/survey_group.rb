class SurveyGroup < ActiveRecord::Base
  validates_presence_of :user_id, :group_name
  has_many :surveys
  belongs_to :user
  validates_uniqueness_of :group_name, :scope => :user_id
  
end
