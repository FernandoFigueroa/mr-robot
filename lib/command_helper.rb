# frozen_string_literal: true

class CommandHelper
  def self.parse_command(command)
    return unless valid_command?(command)

    entered_command, args = command.match(/(\w+)\s?(\d,\d,\w+)?/i).captures

    return [entered_command.downcase, args.split(',')] if entered_command.downcase == 'place' && !args.nil?

    [entered_command.downcase]
  end

  def self.valid_command?(command)
    entered_command, args = command&.match(/(\w+)\s?(\d,\d,\w+)?/i)&.captures

    return true if entered_command&.downcase == 'place' && !args.nil?

    %w[move left right report exit].include?(entered_command&.downcase)
  end
end
