Factory.define :age_group do |age_group|
  age_group.sequence(:description){|n| "#{n * 5} - #{ (n+1) * 5 - 1}"}
end
