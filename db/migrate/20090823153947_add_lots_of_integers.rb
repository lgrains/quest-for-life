class AddLotsOfIntegers < ActiveRecord::Migration
  def self.up
    (1..10).each do |i|
      add_int i
    end
    (2..10).each do |i|
      add_int 10*i
    end
  end

  def self.down
  end

  def self.add_int i
    if RationalOption.quotient_is(i).empty?
      say "Adding #{i}"
      RationalOption.create! :numerator => i, :denominator => 1
    end
  end
end
