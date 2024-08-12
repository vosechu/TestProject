# frozen_string_literal: true

class Rover
  attr_reader :position, :direction

  def initialize(position: [0, 0], direction: 'N')
    @position = position
    @direction = direction
  end

  def left
    case @direction
    when 'N' then @direction = 'W'
    when 'W' then @direction = 'S'
    when 'S' then @direction = 'E'
    when 'E' then @direction = 'N'
    end
  end

  def right
    case @direction
    when 'N' then @direction = 'E'
    when 'E' then @direction = 'S'
    when 'S' then @direction = 'W'
    when 'W' then @direction = 'N'
    end
  end

  def forward
    case @direction
    when 'N' then @position[1] += 1
    when 'E' then @position[0] += 1
    when 'S' then @position[1] -= 1
    when 'W' then @position[0] -= 1
    end
  end

  def look_ahead
    case @direction
    when 'N' then [@position[0], @position[1] + 1]
    when 'E' then [@position[0] + 1, @position[1]]
    when 'S' then [@position[0], @position[1] - 1]
    when 'W' then [@position[0] - 1, @position[1]]
    end
  end
end
