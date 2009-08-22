Factory.define :survey_group do |survey_group|
  survey_group.user_id { Factory(:user) }
  survey_group.sequence(:group_name){|n| "group #{n}"}
end
