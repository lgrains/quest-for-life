class CreateRationals < ActiveRecord::Migration
  def self.up
    create_table :rationals do |t|
      t.integer :numerator, :null => false
      t.integer :denominator, :null => false
      t.decimal :quotient, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :rationals
  end
end
