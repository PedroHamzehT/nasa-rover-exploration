# frozen_string_literal: true

class Rover
  attr_reader :x_position, :y_position

  DIRECTIONS = {
    0 => 'N',
    1 => 'E',
    2 => 'S',
    3 => 'W'
  }.freeze

  def initialize(x_position, y_position, direction)
    @x_position = x_position
    @y_position = y_position
    @direction = DIRECTIONS.key(direction)
  end

  def direction
    DIRECTIONS[@direction]
  end

  def execute_actions(actions, plateau)
    actions.each do |action|
      raise ArgumentError, "Invalid argument, expected R or L or M, got #{action}" unless %w[R L M].include?(action)

      action == 'M' ? move(plateau) : change_direction(action)
    end
  end

  def current
    "#{x_position} #{y_position} #{direction}"
  end

  private

  def invalid_position?(plateau)
    y_position > plateau.up_limit ||
      x_position > plateau.right_limit ||
      plateau.rovers_positions.include?([x_position, y_position])
  end

  def move(plateau)
    case @direction
    when 0
      @y_position += 1
      @y_position -= 1 if invalid_position?(plateau)
    when 1
      @x_position += 1
      @x_position -= 1 if invalid_position?(plateau)
    when 2
      @y_position -= 1
      @y_position += 1 if invalid_position?(plateau)
    when 3
      @x_position -= 1
      @x_position += 1 if invalid_position?(plateau)
    end
  end

  def change_direction(new_direction)
    case new_direction
    when 'R'
      @direction += 1
    when 'L'
      @direction -= 1
    end

    @direction = 3 if @direction.negative?
    @direction = 0 if @direction > 3
  end
end
