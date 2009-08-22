class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
      t.decimal :r_star
      t.decimal :fp
      t.decimal :ne
      t.decimal :fl
      t.decimal :fi
      t.decimal :fc
      t.integer :l
      t.integer :n

      t.timestamps
    end
  end

  def self.down
    drop_table :surveys
  end
end
