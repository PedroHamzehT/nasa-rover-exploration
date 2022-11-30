# frozen_string_literal: true

require_relative 'lib/rover'

File.open('input.txt', 'r') do |file|
  lines = file.readlines
  # plateau_limits = lines[0].split

  rovers = []
  lines[1..].each_slice(2) do |rover_lines|
    rover_position = rover_lines[0].split
    rover = Rover.new(rover_position[0].to_i, rover_position[1].to_i, rover_position[2])
    rover.execute_actions(rover_lines[1].gsub("\n", '').split(''))

    p '**********************************'
    rovers << rover
  end

  rovers.each do |rover|
    p rover.current
  end
end