require_relative 'helper'

class TestExploration < Minitest::Test
  def test_explore_with_valid_actions
    result = Exploration.new('test/test_samples/test_sample_valid_actions.txt').explore
    expected_result = ['1 3 N', '5 1 E']
    assert_equal expected_result, result

    result = Exploration.new('test/test_samples/test_sample_valid_actions_two.txt').explore
    expected_result = ['2 3 W', '3 1 S', '3 4 N']
    assert_equal expected_result, result
  end

  def test_explore_with_invalid_actions
    error = assert_raises(ArgumentError) { Exploration.new('test/test_samples/test_sample_with_invalid_action.txt').explore }
    assert_equal 'Invalid argument, expected R or L or M, got A', error.message
  end

  def test_explore_with_rover_conflicts
    result = Exploration.new('test/test_samples/test_sample_with_rover_conflicts.txt').explore
    expected_result = ['5 3 N', '5 2 N']
    assert_equal expected_result, result
  end
end
