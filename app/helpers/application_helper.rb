# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def title title
    content_for :title, title
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
    haml_tag :a, {:href => url_for(:controller => 'drake', :action => url), :class => class_name, :title => definition} do
      haml_concat(text)
    end
  end
  
  def drake_component(function, options={})
#    str = capture_haml {haml_tag(:span, function, :class => 'function')}
#    str << capture_haml {haml_tag(:sub, options[:sub])} if options[:sub]
#    str << capture_haml {haml_tag(:sup, options[:sup])} if options[:sup]
#    str << capture_haml {haml_tag(:span, options[:operator], :class => 'operator')} if options[:operator]
#    return str

    capture_haml {
      haml_tag(:span, :class => 'function') do
        haml_concat function
        haml_tag(:sub, options[:sub]) if options[:sub]
        haml_tag(:sup, options[:sup]) if options[:sup]
      end
      haml_tag(:span, options[:operator], :class => 'operator') if options[:operator]
    }

  end
  
  def drake_number
    drake_component('N', :operator => '=')
  end
  
  def drake_stars
    drake_component('R', :sup => '*', :operator => '&times;')
  end
  
  def drake_planets
    drake_component('&#402;', :sub => 'p', :operator => '&times;')
  end
  
  def drake_earthlike
    drake_component('n', :sub => 'e', :operator => '&times;')
  end
  
  def drake_life
    drake_component('&#402;', :sub => 'ℓ', :operator => '&times;')
  end
  
  def drake_intelligence
    drake_component('&#402;', :sub => 'i', :operator => '&times;')
  end
  
  def drake_communicate
    drake_component('&#402;', :sub => 'c', :operator => '&times;')
  end
  
  def drake_duration
    drake_component('L')
  end

end
