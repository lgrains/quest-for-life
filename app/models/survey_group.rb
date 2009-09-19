class SurveyGroup < ActiveRecord::Base
  validates_presence_of :user_id, :group_name, :age_group_id, :city, :country
  has_many :surveys
  belongs_to :user
  belongs_to :age_group
  validates_uniqueness_of :group_name, :scope => :user_id
  
  def to_param
    "#{self.id}-#{self.group_name.downcase.gsub(/\W+/,'-')}"
  end
end
