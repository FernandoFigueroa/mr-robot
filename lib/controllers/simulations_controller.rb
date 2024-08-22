# frozen_string_literal: true

require_relative('../models/robot_simulation')

# SimulationsController
# Controller class to handle commands entered by the user, a method is created for each valid commands.
# Is a method does not exist, it'll return an error message
class SimulationsController
  def initialize(echo: false)
    @robot_simulation = RobotSimulation.new
    @echo = echo
  end

  def place(horizontal_coord, vertical_coord, direction)
    response = @robot_simulation.place_robot(horizontal_coord, vertical_coord, direction)

    handle_response(response, [horizontal_coord, vertical_coord, direction])
  end

  def move
    response = @robot_simulation.move_robot

    handle_response(response)
  end

  def report
    response = @robot_simulation.robot_status

    handle_response(response)
  end

  def left
    response = @robot_simulation.rotate_robot('left')

    handle_response(response)
  end

  def right
    response = @robot_simulation.rotate_robot('right')

    handle_response(response)
  end

  def method_missing(method_name, *_args)
    "Invalid action #{method_name}"
  end

  def respond_to_missing?(method_name, include_private = false)
    super
  end

  private

  def handle_response(response, args = [])
    return response unless response.nil? && @echo

    "Command '#{[caller_locations(1, 1)[0].label, args.join(', ')].compact.join(' ').strip}' ignored."
  end
end
