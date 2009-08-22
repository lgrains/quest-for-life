require 'test_helper'

class RationalOptionTest < ActiveSupport::TestCase
  def setup
    @rational_option = Factory.create(:rational_option, :numerator => 1, :denominator => 1)
  end
  
  should_validate_presence_of :numerator, :denominator
  should_validate_numericality_of :numerator, :denominator
  
  test "quotient is calculated" do
    rational = Factory.build(:rational_option, :numerator => 1, :denominator => 10)
    assert_nil rational.quotient
    rational.save!
    assert_equal 0.1, rational.quotient
  end
  
  test "quotient must be unique" do
    rational = Factory.build(:rational_option, 
      :numerator => @rational_option.numerator, :denominator => @rational_option.denominator)
    assert !rational.valid?
    assert_match /has already been taken/, rational.errors.on(:quotient)
  end
  
  test "default scope orders by quotient" do
    first_rational_option = Factory.create(:rational_option, :numerator => 1, :denominator => 10)
    last_rational_option = Factory.create(:rational_option, :numerator => 10, :denominator => 1)
    
    assert_equal [first_rational_option, @rational_option, last_rational_option], RationalOption.all
  end
end
