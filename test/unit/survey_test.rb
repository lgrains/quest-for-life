require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  should_validate_numericality_of :r_star, :fp, :ne, :fl, :fi, :fc, :l, :n
  should_belong_to :survey_group

  test "n is nil if any parameter is nil" do
    # initialize all to non-nil
    params = Survey.parameter_columns.inject({}) { |hash, p| hash["#{p}_rational"] = Factory(:rational_option); hash } 
    survey = Factory.create(:survey, params)
    assert_not_nil survey.n, 'should have a non-nil N'
    
    Survey.parameter_columns.each do |p|
      original_value = survey.send "#{p}_rational"
      survey.send "#{p}_rational=", nil
      survey.save!
      
      assert_nil survey.n
      
      # set the parameter back 
      survey.send "#{p}_rational=", original_value
    end
  end
  
  test "n is calculated correctly" do
    rationals =
      {
        :r_star_rational_id => Factory(:rational_option),
        :fp_rational_id => Factory(:rational_option),
        :ne_rational_id => Factory(:rational_option),
        :fl_rational_id => Factory(:rational_option),
        :fi_rational_id => Factory(:rational_option),
        :fc_rational_id => Factory(:rational_option),
        :l_rational_id => Factory(:rational_option)
      }
    survey = Factory.create(:survey, rationals)

    product = rationals.values.inject(1.0) { |product, v| product * v.quotient }.round
    assert_equal product.round, survey.n
  end
  
  test "slug gets set on create" do
    survey = Factory.build(:survey, :slug => nil)
    assert_nil survey.slug
    survey.save
    assert_not_nil survey.slug
  end
  
  test "to_param returns slug" do
    survey = Factory.build(:survey, :slug => '12345678')
    assert_equal survey.slug, survey.to_param
  end
end
