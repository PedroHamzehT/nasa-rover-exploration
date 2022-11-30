# frozen_string_literal: true

require_relative 'lib/exploration'
require_relative 'lib/plateau'
require_relative 'lib/rover'

Exploration.new('input.txt').explore.each { |rover_pos| p rover_pos }
