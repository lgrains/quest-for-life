class RationalOption < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TextHelper


  default_scope :order => 'quotient'
  
  validates_presence_of :numerator, :denominator, :quotient
  
  validates_numericality_of :numerator, :greater_than_or_equal_to => 0
  validates_numericality_of :denominator, :greater_than => 0
  validates_uniqueness_of :quotient
  
  before_validation :calculate_quotient
  
  attr_accessible :numerator, :denominator
  
  named_scope :integers, {:conditions=>{:quotient => Array(0..100)}}

  def quotient_label
    if self.denominator > 1
      # Rational(self.numerator, self.denominator).to_s\
      
      "#{number_with_delimiter(self.numerator)} in #{number_with_delimiter(self.denominator)}"
    else
      number_with_delimiter(self.numerator)
    end
  end

  def r_star_label
    "#{pluralize quotient.to_i, 'star'} #{quotient==1 ? 'forms' : 'form'} in our galaxy each year"
  end

  def fp_label
    if quotient >= 1
      "every star develops planets"
    else
      "#{number_with_delimiter(self.numerator)} star out of every #{number_with_delimiter(self.denominator)} develops planets"
    end
  end

  def ne_label
    if quotient >= 1
      "#{pluralize quotient.to_i, 'body'} in an average solar system will be capable of liquid water"
    else
      "#{number_with_delimiter(self.numerator)} out of every #{pluralize(number_with_delimiter(self.denominator), 'solar system')} will have one body that supports liquid water"
    end
  end

  def fl_label
    if quotient >= 1
      "every suitable planet will develop life"
    else
      "#{quotient_label} suitable planets will develop life"
    end
  end

  def fi_label
    if quotient >= 1
      "intelligence will develop wherever life develops"
    else
      "#{quotient_label} suitable planets with life will develop intelligence"
    end
  end
  
  def fc_label
    if quotient >= 1
      "every intelligent civilization will discover radio and choose to communicate"
    else
      "#{quotient_label} intelligent civilizations will discover radio and choose to communicate"
    end
  end

  def l_label
    "on average, an advanced society survives #{pluralize number_with_delimiter(quotient.to_i), 'year'}"
  end
  private
  
  def calculate_quotient
    self.quotient = self.numerator.to_f / self.denominator.to_f unless self.denominator.to_i == 0
  end
end
