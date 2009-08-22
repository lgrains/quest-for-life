class AddSlugToSurveys < ActiveRecord::Migration
  def self.up
    add_column :surveys, :slug, :string, :limit => 8
    add_index :surveys, :slug, :unique => true
    
    Survey.all.each do |s|
      s.send :set_slug
      s.save!
    end
  end

  def self.down
    remove_column :surveys, :slug
  end
end
