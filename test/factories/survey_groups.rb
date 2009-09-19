Factory.define :survey_group do |survey_group|
  survey_group.user_id { Factory(:email_confirmed_user) }
  survey_group.sequence(:group_name){|n| "group #{n}"}
  survey_group.age_group { Factory(:age_group) }
  survey_group.city 'Cambridge'
  survey_group.country 'United States'
end
