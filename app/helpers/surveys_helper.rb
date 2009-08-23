module SurveysHelper
  def info_link(name, url)
    link_to name, url, :target => '_blank'
  end
  
  def main_point(text)
    "<a href=\"#\">#{text}&hellip;</a>"
  end

  def parameter_input form, parameter
    rational_attribute = parameter.to_s + '_rational_id'
    collection = Survey.options_for(parameter)
    label_method = "#{parameter}_label".to_sym

    form.input rational_attribute, :collection => collection,
      :include_blank => false,
      :as => :select,
      :value_method => :id,
      :label_method => label_method
  end

  def chart_colors
    colors = 25.times.map { |i| "rgb(#{[128+i*5, i*5, 0].join(',')})"}.reverse
  end
  
  def chart(parameter, dimension, options={})
    options[:parameter] = parameter
    options[:demographic] = dimension
    
    case dimension
    when :age
      options[:dimension] = AgeGroup.all + [AgeGroup.new(:id => nil, :description => 'Unknown')]
      options[:data] = Survey.report("#{parameter}_rational_id", :age_group_id)
      options[:dimension_key_method] = :id
      options[:dimension_label_method] = :description
    when :gender
      options[:dimension] = ['Male','Female',nil]
      options[:data] = Survey.report("#{parameter}_rational_id", :gender)
      options[:dimension_key_method] = :to_s
      options[:dimension_label_method] = :to_s
    else
      raise 'Invalid dimension'
    end
    
    options[:rational_options] = Survey.options_for(parameter)
    
    render :partial => 'chart_set', :locals => options
  end
  
end
