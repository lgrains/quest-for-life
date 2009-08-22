class AddInitialRationalOptions < ActiveRecord::Migration
  def self.up
    (1..6).each do |e|
      RationalOption.create! :numerator => 1, :denominator => 10**e
      RationalOption.create! :numerator => 10**e, :denominator => 1
    end
    
    (1..9).each do |n|
      RationalOption.create! :numerator => 1, :denominator => n
    end
  end

  def self.down
    RationalOption.destroy_all
  end
end
