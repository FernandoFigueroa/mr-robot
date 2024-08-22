# frozen_string_literal: true

require_relative('robot')
require_relative('tabletop')

# Holds the logic to having a robot on a tabletop
class RobotSimulation
  def initialize
    @robot = nil
    @tabletop = Tabletop.new
  end

  def place_robot(horizontal_coord, vertical_coord, direction)
    return unless @tabletop.valid_position?(horizontal_coord, vertical_coord)

    @robot = Robot.new(horizontal_coord, vertical_coord, direction)
  rescue ArgumentError
    nil
  end

  def move_robot
    return unless @robot

    horizontal_coord, vertical_coord = @robot.next_movement

    return unless @tabletop.valid_position?(horizontal_coord, vertical_coord)

    @robot.move
  end

  def robot_status
    return unless @robot

    @robot.status
  end

  def rotate_robot(rotation)
    return unless @robot

    @robot.rotate(rotation)
  end
end
