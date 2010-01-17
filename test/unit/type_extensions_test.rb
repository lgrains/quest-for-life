require File.dirname(__FILE__) + '/../test_helper'

class TypeExtensionsTest < ActiveSupport::TestCase
  context 'A numeric variable' do
    should 'put commas in correctly' do
      assert_equal '1', 1.commify
      assert_equal '10', 10.commify
      assert_equal '100', 100.commify
      
      assert_equal '1,000', 1_000.commify
      assert_equal '10,000', 10_000.commify
      assert_equal '100,000', 100_000.commify
      
      assert_equal '1,000,000', 1_000_000.commify
      assert_equal '1,000,000,000', 1_000_000_000.commify

      assert_equal '100.0', 100.0.commify
      assert_equal '1,000.0', 1_000.0.commify
    end
  end
end