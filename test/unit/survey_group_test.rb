require File.dirname(__FILE__) + '/../test_helper'

class SurveyGroupTest < ActiveSupport::TestCase
  def setup
    1
    @survey_group = Factory(:survey_group)
  end
 
  should_belong_to :user
  should_belong_to :group_age_group
  should_have_many :surveys
  should_have_index [:user_id, :group_name], :unique => true
  should_validate_presence_of :user_id, :group_name
  should_validate_uniqueness_of :group_name, :scoped_to => :user_id, :case_sensitive => true
end
