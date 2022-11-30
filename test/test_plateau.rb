require_relative 'helper'

class TestPlateau < Minitest::Test
  def setup
    @plateau = Plateau.new(5, 5)
  end

  def test_add_rover
    rover = Rover.new(3, 2, 'N')
    rover_two = Rover.new(4, 5, 'S')
    @plateau.add_rover(rover)
    @plateau.add_rover(rover_two)

    expected_result = [rover.current, rover_two.current]
    assert_equal expected_result, @plateau.rovers.map(&:current)
  end
end
