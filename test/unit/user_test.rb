File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = Factory(:user)
  end
  should_have_many :survey_groups
  should_have_db_column :username, :type => :string
  should_validate_uniqueness_of :username, :case_sensitive => :false
  should_validate_presence_of :username
  should_allow_mass_assignment_of :username, :identity_url
  should_not_allow_mass_assignment_of :admin
end
