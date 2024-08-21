# frozen_string_literal: true

require_relative('../robot_challenge')

# Controller class to handle commands entered by the user, a method is created for each valid commands.
# Is a method does not exist, it'll return an error message
class GamesController
  def initialize
    @robot_challenge = RobotChallenge.new
  end

  def place(horizontal_coord, vertical_coord, direction)
    @robot_challenge.place_robot(horizontal_coord, vertical_coord, direction)
  end

  def move
    @robot_challenge.move_robot
  end

  def report
    @robot_challenge.robot_status
  end

  def left
    @robot_challenge.rotate_robot('left')
  end

  def right
    @robot_challenge.rotate_robot('right')
  end

  def method_missing(method_name, *_args)
    "Invalid action #{method_name}"
  end

  def respond_to_missing?(method_name, include_private = false)
    super
  end
end
