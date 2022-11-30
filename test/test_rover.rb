require_relative 'helper'

class TestRover < Minitest::Test
  def setup
    @rover = Rover.new(2, 4, 'N')
    @plateau = Plateau.new(8, 8)
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
    assert_equal 5, @rover.y_position

    @rover.send(:change_direction, 'R')
    @rover.send(:move, @plateau)
    assert_equal 3, @rover.x_position

    @rover.send(:change_direction, 'R')
    @rover.send(:move, @plateau)
    assert_equal 4, @rover.y_position

    @rover.send(:change_direction, 'R')
    @rover.send(:move, @plateau)
    assert_equal 2, @rover.x_position
  end

  def test_execute_actions
    # Valid actions
    @rover.execute_actions(%w[M M R M M L M M], @plateau)

    # Invalid action
    error = assert_raises(ArgumentError) { @rover.execute_actions(%w[A M M R M L M M], @plateau) }
    assert_equal 'Invalid argument, expected R or L or M, got A', error.message

    # Actions that will conflict with plateau limits - it will not move the rover
    @rover.execute_actions(%w[M M M], @plateau)
    assert_equal 8, @rover.y_position # it stays in the plateau limit

    # Actions that will conflict with other rovers positions - it will not move over the other rover position
    rover_two = Rover.new(5, 8, 'S')
    @plateau.add_rover(rover_two)

    @rover.execute_actions(%w[R M M M], @plateau)
    assert_equal 4, @rover.x_position
  end
end
