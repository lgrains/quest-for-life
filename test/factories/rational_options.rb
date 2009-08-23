Factory.define :rational_option do |ro|
  ro.sequence(:numerator){|n| n }
  ro.sequence(:denominator){|n| (n+1)*2 }
end
