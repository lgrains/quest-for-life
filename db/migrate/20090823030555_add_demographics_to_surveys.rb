class AddDemographicsToSurveys < ActiveRecord::Migration
  def self.up
    add_column :surveys, :country, :string
    add_column :surveys, :state, :string
    add_column :surveys, :city, :string
    add_column :surveys, :gender, :string
    add_column :surveys, :age_group_id, :integer
    add_column :surveys, :twitter_username, :string
  end

  def self.down
    remove_column :surveys, :country
    remove_column :surveys, :state
    remove_column :surveys, :city
    remove_column :surveys, :gender
    remove_column :surveys, :age_group_id
    remove_column :surveys, :twitter_username
  end
end
