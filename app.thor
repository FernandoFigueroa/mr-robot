# frozen_string_literal: true

require_relative 'lib/robot_challenge'
require_relative 'lib/command_helper'

# App
# Main application class, executed with Thor, should be considered as the entry point
class App < Thor
  desc 'interactive', 'Runs the app interactive mode, requesting/executing commands one at the time'
  def interactive
    robot_challenge = RobotChallenge.new
    command = ask 'Please enter a valid command'
    parsed_command, args = CommandHelper.parse_command(command)
    if parsed_command
      case parsed_command
      when 'place'
        robot_challenge.place_robot(*args)
      end
    end
  end
end
