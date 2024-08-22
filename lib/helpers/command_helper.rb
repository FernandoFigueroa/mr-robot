# frozen_string_literal: true

# CommandHelper
# Validate and parses a command, to return normalized commands in lowercase
class CommandHelper
  VALID_COMMANDS = %w[move left right report exit].freeze
  VALID_COMMAND_REGEX = /(\w+)\s?(\d,\d,\w+)?/i

  def self.parse_command(command)
    return unless valid_command?(command)

    entered_command, args = command.match(VALID_COMMAND_REGEX).captures

    return ['place', args.split(',')] if entered_command.strip.downcase == 'place' && !args.nil?

    [entered_command.strip.downcase]
  end

  def self.valid_command?(command)
    return false unless command.is_a?(String)

    entered_command, args = command.strip.match(VALID_COMMAND_REGEX)&.captures

    return false unless entered_command

    return true if entered_command.strip.downcase == 'place' && !args.nil?

    VALID_COMMANDS.include?(entered_command.strip.downcase)
  end
end
