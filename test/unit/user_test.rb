File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = Factory(:user)
  end
  should_have_many :survey_groups
  should_have_db_column :login, :type => :string
  should_validate_uniqueness_of :login, :case_sensitive => :false
  should_allow_mass_assignment_of :login, :identity_url
  should_not_allow_mass_assignment_of :admin
end
