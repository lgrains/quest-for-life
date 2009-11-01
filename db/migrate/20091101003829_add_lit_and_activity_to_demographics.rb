class AddLitAndActivityToDemographics < ActiveRecord::Migration
  def self.up
    add_column :surveys, :activity_id, :integer, :null => true
    add_column :surveys, :lit_type_id, :integer, :null => true
  end

  def self.down
    remove_column :surveys, :activity_id
    remove_column :surveys, :lit_type_id
  end
end
