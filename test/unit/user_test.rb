require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should_have_many :survey_groups
end
