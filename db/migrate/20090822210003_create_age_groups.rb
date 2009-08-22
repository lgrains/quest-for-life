class CreateAgeGroups < ActiveRecord::Migration
  def self.up
    create_table :age_groups do |t|
      t.text :description
      t.integer :position
      t.timestamps
    end
    add_index :age_groups, :position
  end

  def self.down
    drop_table :age_groups
  end
end
