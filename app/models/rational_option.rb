class RationalOption < ActiveRecord::Base
  default_scope :order => 'quotient'
  
  validates_presence_of :numerator, :denominator, :quotient
  
  validates_numericality_of :numerator, :greater_than_or_equal_to => 0
  validates_numericality_of :denominator, :greater_than => 0
  validates_uniqueness_of :quotient
  
  before_validation :calculate_quotient
  
  attr_accessible :numerator, :denominator
  
  private
  
  def calculate_quotient
    self.quotient = self.numerator.to_f / self.denominator.to_f unless self.denominator.to_i == 0
  end
end
