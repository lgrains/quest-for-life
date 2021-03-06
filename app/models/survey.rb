# Copyright (c) 2009 Steven Hammond, Cris Necochea, Joe Lind, Jeremy Weiskotten
# 
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.

class Survey < ActiveRecord::Base

  class << self
    def parameter_columns
      [:r_star, :fp, :ne, :fl, :fi, :fc, :l]
    end
    
    def title_for_parameter(p)
      {
        :n => 'Number of Civilizations',
        :r_star => 'Rate of Stellar Formation',
        :fp => "Fraction of Stars that Develop Planets",
        :ne => 'Number of Earthlike Planets',
        :fl => 'Frequency of Life Developing',
        :fi => 'Frequency of Intelligence Evolving',
        :fc => 'Frequency of Intelligent Civilization Communicating',
        :l => "Life Expectancy of an Advanced Society"
      }[p.to_sym]
    end
    
    def question_for_parameter(p)
      {
        :n => 'How many civilizations that might communicate with us are there in our galaxy?',
        :r_star => 'How many stars form in our galaxy each year?',
        :fp => "How many suitable stars actually form a solar system with planets in it?",
        :ne => 'What\'s the average number of bodies in a solar system capable of supporting liquid water?',
        :fl => 'How hard is it for life to start on a suitable planet?',
        :fi => 'If life starts on a planet, how likely is intelligence to develop?',
        :fc => 'Will an advanced civilization discover radio and choose to use it to communicate?',
        :l => "How many years can an advanced society survive?"
      }[p.to_sym]
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
        when n <= 10 then ''||n
        when n <= 20 then '10-20'
        when n <= 100 then '21-100'
        else 'over 100' END) as group_col"
      else
        sql_parameter = "#{parameter} as group_col"
      end
      sql = "select #{sql_parameter}, #{axis}, count(*) as count_surveys,
        min(#{parameter}) as min, max(#{parameter}) as max,
        avg(#{parameter}) as average, stddev_pop(#{parameter}) as stdev
        from #{table_name}
        where n is not null 
        group by group_col, #{axis}"
      
      # Initialize the results hash
      report_hash = {
        :count => {},
        :min => {},
        :max => {},
        :average => {},
        :stdev => {},
        :rational_options => [],
        :values => {}
      }
      Survey.find_by_sql(sql).each do |group|
        group_label = group.send(axis).blank? ? nil : group.send(axis)
        
        # initialize some values
        report_hash[:count][group_label] = 0 if report_hash[:count][group_label].nil?
        report_hash[:average][group_label] = 0 if report_hash[:average][group_label].nil?
        report_hash[:stdev][group_label] = 0.0 if report_hash[:stdev][group_label].nil?
        
        report_hash[:count][group_label] += group.count_surveys.to_i
        if report_hash[:min][group_label].nil? || report_hash[:min][group_label] > group.min.to_i
          report_hash[:min][group_label] = group.min.to_i
        end
        if report_hash[:max][group_label].nil? || report_hash[:max][group_label] < group.max.to_i
          report_hash[:max][group_label] = group.max.to_i
        end
        report_hash[:average][group_label] += (group.average.to_i * group.count_surveys.to_i)
        report_hash[:stdev][group_label] += (group.stdev.to_f * group.count_surveys.to_f)
        
        report_hash[:rational_options] << group.group_col
        report_hash[:values][group_label] = {} if report_hash[:values][group_label].nil?
        if report_hash[:values][group_label][group.group_col]
          report_hash[:values][group_label][group.group_col] += group.count_surveys.to_i
        else
          report_hash[:values][group_label][group.group_col] = group.count_surveys.to_i
        end
      end
      report_hash[:rational_options] = report_hash[:rational_options].uniq
      report_hash[:average].each do |key, value|
        report_hash[:average][key] = value/report_hash[:count][key]
      end
      report_hash[:stdev].each do |key, value|
        report_hash[:stdev][key] = value/report_hash[:count][key]
      end
      return report_hash
    end

  end

  belongs_to :survey_group
  belongs_to :age_group
    
  validates_numericality_of parameter_columns, :n, :greater_than_or_equal_to => 0, :allow_nil => true
  validates_presence_of :slug
  validates_uniqueness_of :slug, :on => :create

  before_validation_on_create :set_slug
  before_validation :strip_at_from_twitter_username
  before_save :store_group_demigraphics
  before_save :calculate_quotients
  before_save :cleanup_empty_strings
  
  attr_accessible *(parameter_columns.map{|p| "#{p}_rational_id".to_sym })
  attr_accessible :city, :state, :country, :age_group_id, :gender, :activity_id, :lit_type_id, :twitter_username

  belongs_to :lit_type
  belongs_to :activity

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
  
  def address
    "#{self.city}, #{self.state+' '}#{self.country}"
  end
  
  private
  
  def store_group_demigraphics
    if survey_group
      self.country = survey_group.country
      self.state = survey_group.state
      self.city = survey_group.city
      self.age_group_id = survey_group.age_group_id
    end
  end
  
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
  
  def cleanup_empty_strings
    self.gender = nil if self.gender == ''
  end
end
