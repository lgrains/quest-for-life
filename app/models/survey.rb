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

    def options_for(parameter)
      send("#{parameter}_options")
    end

    def r_star_options
      RationalOption.integers.quotient_gte(0).quotient_lte(100)
    end

    def fp_options
      RationalOption.quotient_gte((10**-6).to_f).quotient_lte(1)
    end

    def ne_options
      RationalOption.quotient_gte((10**-2).to_f).quotient_lte(10)
    end

    alias fl_options :fp_options
    alias fi_options :fp_options
    alias fc_options :fp_options

    def l_options
      RationalOption.quotient_gte(1).quotient_lte(10**6).reject{|o| Math.log10(o.quotient) % 1 != 0}
    end
    
    def report(parameter, axis)
      if 'n' == parameter.to_s
        sql_parameter = "( SELECT CASE
        when n <= 10 then n
        when n <= 20 then '10-20'
        when n <= 100 then '21-100'
        else 'over 100' END) as group_col"
      else
        sql_parameter = "#{parameter} as group_col"
      end
      sql = "select #{sql_parameter}, #{axis}, count(*) as count_surveys
        from #{table_name}
        where n is not null 
        group by group_col, #{axis}"

      Survey.find_by_sql(sql).inject({}) do |hash, group|
          hash[[group.group_col, group.send(axis)]] = group.count_surveys.to_i
        hash
      end
    end

  end

  belongs_to :survey_group
  belongs_to :age_group
    
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
