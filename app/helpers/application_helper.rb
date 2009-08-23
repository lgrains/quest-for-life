# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def title title, heading=title
    content_for :title, title
    content_for :heading, heading
  end
  
  def link_to(*args,&block)
    if block_given?
      concat(super(capture(&block), *args), block.binding)
    else
      super(*args)
    end
  end
  
  def drake_link(text, url, definition)
    class_name = (@parameter == url) ? 'yah drake' : 'drake'
    if session[:survey_id].present?
      survey = Survey.find(session[:survey_id]) 
      path = survey_parameter_path(survey, url)
    else
      # just browsing
      path = equation_parameter_path(url)
    end
    
    haml_tag :a, {:href => path, :class => class_name, :title => definition} do
      haml_concat(text)
    end
  end
  
  def drake_component(function, options={})
    capture_haml do
      haml_tag(:span, :class => 'function') do
        haml_concat function
        haml_tag(:sub, options[:sub]) if options[:sub]
        haml_tag(:sup, options[:sup]) if options[:sup]
      end
    end
  end
  
  def parameter_to_drake_component(parameter=@parameter)
    {
      'r_star' => drake_stars,
      'fp' => drake_planets,
      'ne' => drake_earthlike,
      'fl' => drake_life,
      'fi' => drake_intelligence,
      'fc' => drake_communicate,
      'l' => drake_duration
    }[parameter]
  end
  
  def drake_operator(op='&times;')
    haml_tag :span, op, :class => 'operator'
  end
  
  def drake_number
    drake_component('N')
  end
  
  def drake_stars
    drake_component('R', :sup => '*')
  end
  
  def drake_planets
    drake_component('&#402;', :sub => 'p')
  end
  
  def drake_earthlike
    drake_component('n', :sub => 'e')
  end
  
  def drake_life
    drake_component('&#402;', :sub => 'ℓ')
  end
  
  def drake_intelligence
    drake_component('&#402;', :sub => 'i')
  end
  
  def drake_communicate
    drake_component('&#402;', :sub => 'c')
  end
  
  def drake_duration
    drake_component('L')
  end

  def state_options
    [ 	
    	['Select a State or Province', ''],
    	['Alabama', 'AL'], 
    	['Alaska', 'AK'],
    	['Arizona', 'AZ'],
    	['Arkansas', 'AR'], 
    	['California', 'CA'], 
    	['Colorado', 'CO'], 
    	['Connecticut', 'CT'], 
    	['Delaware', 'DE'], 
    	['District Of Columbia', 'DC'], 
    	['Florida', 'FL'],
    	['Georgia', 'GA'],
    	['Hawaii', 'HI'], 
    	['Idaho', 'ID'], 
    	['Illinois', 'IL'], 
    	['Indiana', 'IN'], 
    	['Iowa', 'IA'], 
    	['Kansas', 'KS'], 
    	['Kentucky', 'KY'], 
    	['Louisiana', 'LA'], 
    	['Maine', 'ME'], 
    	['Maryland', 'MD'], 
    	['Massachusetts', 'MA'], 
    	['Michigan', 'MI'], 
    	['Minnesota', 'MN'],
    	['Mississippi', 'MS'], 
    	['Missouri', 'MO'], 
    	['Montana', 'MT'], 
    	['Nebraska', 'NE'], 
    	['Nevada', 'NV'], 
    	['New Hampshire', 'NH'], 
    	['New Jersey', 'NJ'], 
    	['New Mexico', 'NM'], 
    	['New York', 'NY'], 
    	['North Carolina', 'NC'], 
    	['North Dakota', 'ND'], 
    	['Ohio', 'OH'], 
    	['Oklahoma', 'OK'], 
    	['Oregon', 'OR'], 
    	['Pennsylvania', 'PA'], 
    	['Rhode Island', 'RI'], 
    	['South Carolina', 'SC'], 
    	['South Dakota', 'SD'], 
    	['Tennessee', 'TN'], 
    	['Texas', 'TX'], 
    	['Utah', 'UT'], 
    	['Vermont', 'VT'], 
    	['Virginia', 'VA'], 
    	['Washington', 'WA'], 
    	['West Virginia', 'WV'], 
    	['Wisconsin', 'WI'], 
    	['Wyoming', 'WY'],
    	
    	['Alberta', 'AB'],
      ['British Columbia','BC'],
      ['Manitoba','MB'],
      ['New Brunswick','NB'],
      ['Newfoundland and Labrador','NL'],
      ['Northwest Territories','NT'],
      ['Nova Scotia','NS'],
      ['Nunavut','NU'],
      ['Ontario','ON'],
      ['Prince Edward Island','PE'],
      ['Quebec','QC'],
      ['Saskatchewan','SK'],
      ['Yukon','YT']
      
  	]
  end
end
