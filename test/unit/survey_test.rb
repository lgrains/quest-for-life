require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  should_validate_numericality_of :r_star, :fp, :ne, :fl, :fi, :fc, :l, :n
  should_belong_to :survey_group
  should_belong_to :lit_type
  should_belong_to :activity
  should_not_allow_mass_assignment_of :id, :created_at, :updated_at
  
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
        :r_star_rational_id => Factory.create(:rational_option).id,
        :fp_rational_id => Factory.create(:rational_option).id,
        :ne_rational_id => Factory.create(:rational_option).id,
        :fl_rational_id => Factory.create(:rational_option).id,
        :fi_rational_id => Factory.create(:rational_option).id,
        :fc_rational_id => Factory.create(:rational_option).id,
        :l_rational_id => Factory.create(:rational_option).id
      }
    survey = Factory.create(:survey, rationals)
    product = rationals.values.inject(1.0) { |product, v| product * RationalOption.find(v).quotient }.round
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
  
  test "gender should not save as an empty string" do
    survey = Factory.create(:survey, :gender => nil)
    assert_equal nil, survey.gender
    
    survey.gender = ''
    assert survey.save
    assert_equal nil, survey.gender

    survey.gender = "Male"
    assert survey.save
    assert_equal "Male", survey.gender
  end
end
