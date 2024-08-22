# frozen_string_literal: true

# Validate and parses a command, to return normalized commands in lowercase
class CommandHelper
  VALID_COMMANDS = %w[move left right report exit].freeze

  def self.parse_command(command)
    return unless valid_command?(command)

    entered_command, args = command.match(/(\w+)\s?(\d,\d,\w+)?/i).captures

    return [entered_command.downcase, args.split(',')] if entered_command.downcase == 'place' && !args.nil?

    [entered_command.downcase]
  end

  def self.valid_command?(command)
    entered_command, args = command&.match(/(\w+)\s?(\d,\d,\w+)?/i)&.captures

    return true if entered_command&.downcase == 'place' && !args.nil?

    VALID_COMMANDS.include?(entered_command&.downcase)
  end
end
