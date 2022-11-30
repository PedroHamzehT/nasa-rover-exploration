# frozen_string_literal: true

class Plateau
  attr_reader :rovers

  def initialize(up_limit, right_limit)
    @up_limit = up_limit
    @right_limit = right_limit
    @rovers = []
  end

  def add_rover(rover)
    @rovers << rover
  end
end
