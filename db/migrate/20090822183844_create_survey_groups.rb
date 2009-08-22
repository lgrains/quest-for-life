class CreateSurveyGroups < ActiveRecord::Migration
  def self.up
    create_table :survey_groups do |t|
      t.integer :user_id, :null => false
      t.string :group_name
      t.integer :age_group_id, :null => true
      t.timestamps
    end
    add_index :survey_groups, [:user_id, :group_name], :unique => true

  end

  def self.down
    drop_table :survey_groups
  end
end
