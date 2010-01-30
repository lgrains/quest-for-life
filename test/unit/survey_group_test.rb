require File.dirname(__FILE__) + '/../test_helper'

class SurveyGroupTest < ActiveSupport::TestCase
  def setup
    @survey_group = Factory(:survey_group)
  end
 
  should_belong_to :user
  should_belong_to :age_group
  should_have_many :surveys
  should_validate_presence_of :user_id, :group_name, :age_group_id, :country, :city
  should_validate_uniqueness_of :group_name, :scoped_to => :user_id, :case_sensitive => true
  
  context 'An instance of a survey group' do
    setup do
      @survey_group = Factory(:survey_group, :group_name => 'Test Group')
    end
    should 'include its name as part of the url' do
      assert_equal "#{@survey_group.id}-test-group", @survey_group.to_param
    end
  end
end
