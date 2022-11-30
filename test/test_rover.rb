require_relative 'helper'

class TestRover < Minitest::Test
  def setup
    @rover = Rover.new(1, 1, 'N')
    @plateau = Plateau.new(6, 6)
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
    @rover.send(:move, @plateau)
    assert_equal 2, @rover.y_position

    @rover.send(:change_direction, 'R')
    @rover.send(:move, @plateau)
    assert_equal 2, @rover.x_position

    @rover.send(:change_direction, 'R')
    @rover.send(:move, @plateau)
    assert_equal 1, @rover.y_position

    @rover.send(:change_direction, 'R')
    @rover.send(:move, @plateau)
    assert_equal 1, @rover.x_position
  end

  def test_execute_actions
    # Valid actions
    @rover.execute_actions(%w[M M R M M L M], @plateau)
    assert_equal 3, @rover.x_position
    assert_equal 4, @rover.y_position

    # Invalid action
    error = assert_raises(ArgumentError) { @rover.execute_actions(%w[A M M R M L M M], @plateau) }
    assert_equal 'Invalid argument, expected R or L or M, got A', error.message
  end

  def test_execute_actions_conflicting_with_plateau
    # Actions that will conflict with plateau limits - it will not move the rover
    @rover.execute_actions(%w[M M M M M M M M M M], @plateau)
    assert_equal 6, @rover.y_position # it stays in the plateau limit
  end

  def test_execute_actions_conflicting_with_other_rover
    # Actions that will conflict with other rovers positions - it will not move over the other rover position
    other_rover = Rover.new(3, 3, 'S')
    @plateau.add_rover(other_rover)

    @rover.execute_actions(%w[M M R M M M M M], @plateau)
    assert_equal 2, @rover.x_position
    assert_equal 3, @rover.y_position
  end
end
