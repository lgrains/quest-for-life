class Survey < ActiveRecord::Base

  class << self
    def parameter_columns
      [:r_star, :fp, :ne, :fl, :fi, :fc, :l]
    end

    def next_parameter(requested_parameter)
      return parameter_columns.first if requested_parameter.nil?
      requested_parameter = requested_parameter.to_sym
      raise "Invalid parameter: #{requested_parameter}" unless parameter_columns.include?(requested_parameter)
      index = parameter_columns.index(requested_parameter)
      parameter_columns[index+1]
    end
  end

  belongs_to :survey_group
    
  validates_numericality_of parameter_columns, :n, :greater_than_or_equal_to => 0, :allow_nil => true
  validates_presence_of :slug
  validates_uniqueness_of :slug, :on => :create

  before_validation_on_create :set_slug
  before_validation :strip_at_from_twitter_username
  before_save :calculate_quotients
  
  attr_accessible *(parameter_columns.map{|p| "#{p}_rational_id".to_sym })
  attr_accessible :city, :state, :country, :age_group_id, :gender, :twitter_username

  belongs_to :r_star_rational, :class_name => 'RationalOption'
  belongs_to :fp_rational, :class_name => 'RationalOption'
  belongs_to :ne_rational, :class_name => 'RationalOption'
  belongs_to :fl_rational, :class_name => 'RationalOption'
  belongs_to :fi_rational, :class_name => 'RationalOption'
  belongs_to :fc_rational, :class_name => 'RationalOption'
  belongs_to :l_rational, :class_name => 'RationalOption'
  
  def to_param
    slug
  end
  
  def completed?
    self.n.present?
  end
  
  private
  
  def calculate_quotients
    Survey.parameter_columns.each do |column|
      send("#{column}=", send("#{column}_rational").try(:quotient))
    end
    values = Survey.parameter_columns.map { |p| self.send(p) }
    if values.all?
      self.n = values.inject(1.0) { |product, v| product * v }.round
    else
      self.n = nil
    end
    true
  end
  
  def set_slug
    self.slug = ActiveSupport::SecureRandom.hex(4) # 8 hex digits
  end
  
  def strip_at_from_twitter_username
    self.twitter_username.gsub!('@', '') if self.twitter_username.present?
  end
  
end
