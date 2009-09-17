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
  
  context 'The User class' do
    setup do
      @user = Factory(:email_confirmed_user)
    end
    should 'be able to search by id or username from an ambiguous parameter' do
      assert_equal @user, User.find_by_id_or_username(@user.id.to_s)
      assert_equal @user, User.find_by_id_or_username(@user.id)
      assert_equal @user, User.find_by_id_or_username(@user.to_param)
      assert_equal @user, User.find_by_id_or_username(@user.username)
    end
    should 'return nil with illegal search parameters' do
      assert_nil User.find_by_id_or_username((@user.id+1).to_s)
      assert_nil User.find_by_id_or_username(@user.username << @user.username)
    end
  end
end
