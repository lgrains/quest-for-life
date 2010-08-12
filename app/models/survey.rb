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
	
	#select r_star, count(*) as count  from surveys where age_group_id = 5  group by floor(log10(n))
	def new_report(param, dimension, selection)
		
		p = Survey.find(:all, :conditions=>["#{param} >0  and #{dimension} = ?", selection])
		q = p.collect{|e| e.n.to_f}
		r = q.inject(Array.new(4,0)){ |h,e| h[Math.log10(e).to_i] +=1  if e < 10000; h}
	end #def
	
	#returns all the data from the surveys table for the particular param with that dimension
	#whichGroup is either an :age_group_id or :gender
	#     Survey.find(:all, :conditions=>["#{param} and age_group_id = #{age}"]) this works in the console
	def report  param, dimension, selection
		if dimension == :age
			if selection
				res = Survey.find(:all, :conditions => ["#{param}>0 and age_group_id = #{selection}"])
			else
				res = Survey.find(:all, :conditions => ["#{param} >0 and age_group_id is NULL"])
			end
		elsif dimension == :gender 
			if selection
				res = Survey.find(:all, :conditions => ["#{param} >0 and gender = '#{selection}'"])
			else
				res = Survey.find(:all, :conditions => ["#{param} > 0  and gender is NULL"])
			end
		elsif dimension == :all
			res = Survey.find(:all, :conditions => ["#{param} > 0"])
		end
		p =res.collect {|e| Survey.get_param(param, e)}
		if !p
			raise "Bad Array"
		end
		
		Survey.counts(p,param).join(',')
	end
	############
	def get_param param, inp
		case param
			when 'n'; 		inp.n
			when 'r_star': 	inp.r_star
			when 'fp':		inp.fp
			when 'ne': 		inp.ne
			when 'fl':		inp.fl
			when 'fi':		inp.fi
			when 'fc':		inp.fc
			when 'l':		inp.l
			else			"Invalid parameter"
		end
	end
	
	def counts data, param	#data is an array of Surveys
		data.inject(Array.new(4,0)) do |h,e|
			if 	e > 0 and e <= 10
				h[0] +=1
			elsif e<= 100
				h[1]+=1
			elsif e <=1000
				h[2] +=1
			elsif e <= 10000
				h[3] += 1
			end	
			h
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




