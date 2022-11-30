# frozen_string_literal: true

class Exploration
  def initialize(file)
    @file = file
  end

  def explore
    File.open(@file, 'r') do |file|
      lines = file.readlines
      @plateau = Plateau.new(*lines[0].split.map(&:to_i))

      lines[1..].each_slice(2) do |rover_lines|
        rover = rover_actions(rover_lines)
        @plateau.add_rover(rover)
      end

      @plateau.rovers.map(&:current)
    end
  end

  private

  def rover_actions(rover_lines)
    rover_position = rover_lines[0].split
    rover = Rover.new(rover_position[0].to_i, rover_position[1].to_i, rover_position[2])

    actions = rover_lines[1].gsub("\n", '').split('')
    rover.execute_actions(actions, @plateau)

    rover
  end
end
