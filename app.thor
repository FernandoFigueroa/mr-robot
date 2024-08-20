# frozen_string_literal: true

require_relative 'lib/controllers/games_controller'
require_relative 'lib/command_helper'

# App
# Main application class, executed with Thor, should be considered as the entry point
class App < Thor
  desc 'interactive', 'Runs the app interactive mode, requesting/executing commands one at the time'
  def interactive
    controller = GamesController.new
    loop do
      command = ask 'Please enter a valid command or type exit to stop'
      parsed_command, args = CommandHelper.parse_command(command)

      if parsed_command == 'exit'
        self.class.handle_exit
        break
      end

      if parsed_command
        response = controller.public_send(parsed_command.to_sym, *args)
        say response if response.is_a? String
      else
        say 'Invalid command'
      end
    end
  rescue SystemExit, Interrupt
    self.class.handle_exit
  end

  def self.handle_exit
    puts '', 'Bye'
  end
end
