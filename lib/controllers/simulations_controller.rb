# frozen_string_literal: true

require_relative('../models/robot_simulation')

# Controller class to handle commands entered by the user, a method is created for each valid commands.
# Is a method does not exist, it'll return an error message
class SimulationsController
  def initialize
    @robot_simulation = RobotSimulation.new
  end

  def place(horizontal_coord, vertical_coord, direction)
    @robot_simulation.place_robot(horizontal_coord, vertical_coord, direction)
  end

  def move
    @robot_simulation.move_robot
  end

  def report
    @robot_simulation.robot_status
  end

  def left
    @robot_simulation.rotate_robot('left')
  end

  def right
    @robot_simulation.rotate_robot('right')
  end

  def method_missing(method_name, *_args)
    "Invalid action #{method_name}"
  end

  def respond_to_missing?(method_name, include_private = false)
    super
  end
end
