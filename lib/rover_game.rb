# frozen_string_literal: true

require './lib/rover_game/rover'
require './lib/rover_game/infinite_plane'

class RoverGame
  def initialize
    @rover = Rover.new
    @infinite_plane = InfinitePlane.new(rover: @rover, obstacles: [Obstacle.new(position: [0, 1])])
  end

  def run
    puts 'Welcome to the Mars Rover Game!'
    puts 'Position (0,0), Direction (N)'
    puts 'Turn left (a), Go forward (w), Turn right (d)'

    loop do
      command = gets.chomp
      case command
      when 'a'
        @rover.left
      when 'w'
        fail_message and next unless @infinite_plane.rover_forward
      when 'd'
        @rover.right
      end
      puts "Position: #{@rover.position}, Direction: #{@rover.direction}"
    end
  end

  def fail_message
    puts 'Cannot move forward. Obstacle detected.'
  end
end

# Run this code only when started from the command-line
RoverGame.new.run if __FILE__ == $PROGRAM_NAME
