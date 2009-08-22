class AgeGroup < ActiveRecord::Base
  has_many :survey_groups
  has_many :surveys, :through => :survey_groups
end
