# frozen_string_literal: true

require_relative('../robot_challenge')

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

  def method_missing(m, *_args)
    "Invalid action #{m}"
  end
end
