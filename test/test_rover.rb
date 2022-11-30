require 'minitest/autorun'
require_relative '../lib/rover'

class TestRover < Minitest::Test
  def setup
    @rover = Rover.new(2, 4, 'N')
  end

  def test_current
    expected_result = "#{@rover.x_position} #{@rover.y_position} #{@rover.direction}"
    assert_equal expected_result, @rover.current
  end

  def test_change_direction
    @rover.send(:change_direction, 'R')
    assert_equal 'E', @rover.direction

    @rover.send(:change_direction, 'R')
    assert_equal 'S', @rover.direction

    @rover.send(:change_direction, 'R')
    assert_equal 'W', @rover.direction

    @rover.send(:change_direction, 'R')
    assert_equal 'N', @rover.direction

    @rover.send(:change_direction, 'L')
    assert_equal 'W', @rover.direction

    @rover.send(:change_direction, 'L')
    assert_equal 'S', @rover.direction

    @rover.send(:change_direction, 'L')
    assert_equal 'E', @rover.direction

    @rover.send(:change_direction, 'L')
    assert_equal 'N', @rover.direction
  end

  def test_move
    @rover.send(:move)
    assert_equal 5, @rover.y_position

    @rover.send(:change_direction, 'R')
    @rover.send(:move)
    assert_equal 3, @rover.x_position

    @rover.send(:change_direction, 'R')
    @rover.send(:move)
    assert_equal 4, @rover.y_position

    @rover.send(:change_direction, 'R')
    @rover.send(:move)
    assert_equal 2, @rover.x_position
  end

  def test_execute_actions
    # Valid actions
    @rover.execute_actions(%w[M M R M M L M M])

    # Invalid action
    error = assert_raises(ArgumentError) { @rover.execute_actions(%w[M M R M A L M M]) }
    assert_equal 'Invalid argument, expected R or L or M, got A', error.message
  end
end
