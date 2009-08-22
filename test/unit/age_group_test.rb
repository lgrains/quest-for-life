require 'test_helper'

class AgeGroupTest < ActiveSupport::TestCase
  should_have_many :survey_groups
  should_have_many :surveys
  should_have_index :position
  should_have_db_column :description, :type => :text
end
