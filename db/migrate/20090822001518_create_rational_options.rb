class CreateRationalOptions < ActiveRecord::Migration
  def self.up
    create_table :rational_options do |t|
      t.integer :numerator, :null => false
      t.integer :denominator, :null => false
      t.decimal :quotient, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :rational_options
  end
end
