# frozen_string_literal: true

class InfinitePlane
  attr_reader :rover

  def initialize(rover: Rover.new, obstacles: [])
    @rover = rover
    @obstacles = obstacles
  end

  def rover_forward
    if clear?
      @rover.forward
      true
    else
      false
    end
  end

  private

  def clear?
    @obstacles.none? { |obstacle| obstacle.position == @rover.look_ahead }
  end
end

class Obstacle
  attr_reader :position

  def initialize(position:)
    @position = position
  end
end
