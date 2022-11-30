# frozen_string_literal: true

class Plateau
  attr_reader :rovers, :up_limit, :right_limit, :rovers_positions

  def initialize(up_limit, right_limit)
    @up_limit = up_limit
    @right_limit = right_limit
    @rovers = []
    @rovers_positions = []
  end

  def add_rover(rover)
    @rovers << rover
    @rovers_positions << [rover.x_position, rover.y_position]
  end
end
