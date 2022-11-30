# frozen_string_literal: true

class Rover
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

  def execute_actions(actions)
    actions.each do |action|
      action == 'M' ? move : change_direction(action)
      p current
    end
  end

  def move
    case @direction
    when 0
      @x_position += 1
    when 1
      @y_position += 1
    when 2
      @x_position -= 1
    when 3
      @y_position -= 1
    end
  end

  def change_direction(new_direction)
    new_direction == 'R' ? @direction += 1 : @direction -= 1
    @direction = 3 if @direction.negative?
    @direction = 0 if @direction > 3
  end

  def current
    y_position = @y_position
    y_position += 1 if @direction.zero?
    "#{@x_position} #{y_position} #{DIRECTIONS[@direction]}"
  end
end
