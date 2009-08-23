class AddForeignKeysToSurveys < ActiveRecord::Migration
  def self.up
    add_column :surveys,  :r_star_rational_id, :integer
    add_column :surveys,  :fp_rational_id, :integer
    add_column :surveys,  :ne_rational_id, :integer
    add_column :surveys,  :fl_rational_id, :integer
    add_column :surveys,  :fi_rational_id, :integer
    add_column :surveys,  :fc_rational_id, :integer
    add_column :surveys,  :l_rational_id, :integer
  end

  def self.down
    remove_column :surveys,  :r_star_rational_id
    remove_column :surveys,  :fp_rational_id
    remove_column :surveys,  :ne_rational_id
    remove_column :surveys,  :fl_rational_id
    remove_column :surveys,  :fi_rational_id
    remove_column :surveys,  :fc_rational_id
    remove_column :surveys,  :l_rational_id
  end
end
