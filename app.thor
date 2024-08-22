# frozen_string_literal: true

require_relative 'lib/controllers/simulations_controller'
require_relative 'lib/helpers/command_helper'

# App
# Main application class, executed with Thor, should be considered as the entry point
class App < Thor
  desc 'interactive', 'Runs the app interactive mode, requesting/executing commands one at the time'
  def interactive
    controller = SimulationsController.new(echo: true)
    say 'Please enter a valid command or type exit to stop'
    loop do
      command = ask 'What would you like the robot to do?'
      parsed_command, args = CommandHelper.parse_command(command)

      if parsed_command == 'exit'
        self.class.handle_exit
        break
      end

      if parsed_command
        response = controller.public_send(parsed_command.to_sym, *args)
        say response if response.is_a? String
      else
        say 'Please enter a valid command.'
      end
    end
  rescue SystemExit, Interrupt
    self.class.handle_exit
  end

  desc 'import spec/fixture/commands.txt', 'Reads a text file with commands and executes them one by one'
  def import(commands_file)
    controller = SimulationsController.new
    File.open(commands_file) do |file|
      file.lazy.each_slice(100) do |commands|
        commands.each do |command|
          parsed_command, args = CommandHelper.parse_command(command)

          next unless parsed_command

          response = controller.public_send(parsed_command.to_sym, *args)
          say response if response.is_a? String
        end
      end
    end
  rescue StandardError
    puts 'Looks like you entered an invalid file.'
  end

  def self.handle_exit
    puts '', 'Bye'
  end

  def self.exit_on_failure?
    true
  end
end
