Factory.define :survey do |survey|
end

Factory.define :completed_survey, :parent => :survey do |survey|
  survey.r_star 1
  survey.fp     1
  survey.ne     1
  survey.fl     1
  survey.fi     1
  survey.fc     1
  survey.l      1
  survey.n      1
end