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
end
