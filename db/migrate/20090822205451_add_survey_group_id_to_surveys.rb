class AddSurveyGroupIdToSurveys < ActiveRecord::Migration
  def self.up
    add_column :surveys, :survey_group_id, :integer
    add_index :surveys, :survey_group_id
  end

  def self.down
    remove_column :surveys, :survey_group_id
  end
end
