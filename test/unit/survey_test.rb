require 'test_helper'

class SurveyTest < ActiveSupport::TestCase

  should_validate_numericality_of :r_star, :fp, :ne, :fl, :fi, :fc, :l, :n

  test "n is nil if any parameter is nil" do
    # initialize all to non-nil
    params = Survey.parameter_columns.inject({}) { |hash, p| hash[p] = 1; hash } 
    survey = Factory.create(:survey, params)
    assert_not_nil survey.n, 'should have a non-nil N'
    
    Survey.parameter_columns.each do |p|
      survey.send "#{p}=", nil
      survey.save!
      
      assert_nil survey.n
      
      # set the parameter back 
      survey.send "#{p}=", 1
    end
  end
  
  test "n is calculated correctly" do
    survey = Factory.create(:survey, :r_star => 4, :fp => 1.0, :ne => 3, :fl => 0.5, :fi => 0.25, :fc => 0.1, :l => 2000)
    assert_equal (4 * 1.0 * 3 * 0.5 * 0.25 * 0.1 * 2000).round, survey.n
  end
end
