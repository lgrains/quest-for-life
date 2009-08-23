Factory.define :survey do |survey|
end

Factory.define :completed_survey, :parent => :survey do |survey|
  survey.r_star_rational { Factory(:rational_option)}
  survey.fp_rational { Factory(:rational_option)}
  survey.ne_rational { Factory(:rational_option)}
  survey.fl_rational { Factory(:rational_option)}
  survey.fi_rational { Factory(:rational_option)}
  survey.fc_rational { Factory(:rational_option)}
  survey.l_rational { Factory(:rational_option)}
  survey.n  1
end
