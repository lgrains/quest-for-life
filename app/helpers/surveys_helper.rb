module SurveysHelper
  def info_link(name, url)
    link_to name, url, :target => '_blank'
  end
  
  def main_point(text)
    "<a href=\"#\">#{text}&hellip;</a>"
  end
end
