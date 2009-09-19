class AddDemographicsToGroup < ActiveRecord::Migration
  def self.up
    add_column :survey_groups, :country, :string
    add_column :survey_groups, :state, :string
    add_column :survey_groups, :city, :string
    add_column :survey_groups, :num_students, :integer
  end

  def self.down
    remove_column :survey_groups, :country
    remove_column :survey_groups, :state
    remove_column :survey_groups, :city
    remove_column :survey_groups, :num_students
  end
end
