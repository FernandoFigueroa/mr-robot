# frozen_string_literal: true

# Robot
# Handles the robot positioning and movement, not aware of where it's being placed
class Robot
  attr_accessor :horizontal_coord, :vertical_coord, :direction

  VALID_DIRECTIONS = %w[north east south west].freeze
  VALID_ROTATIONS = %w[left right].freeze
  DEFAULT_STEP = 1

  def initialize(horizontal_coord, vertical_coord, direction)
    raise ArgumentError, invalid_direction_message unless valid_direction?(direction)

    self.direction = direction.downcase
    self.horizontal_coord = horizontal_coord.to_i
    self.vertical_coord = vertical_coord.to_i
  end

  def move
    horizontal_coord, vertical_coord = next_movement
    self.horizontal_coord = horizontal_coord
    self.vertical_coord = vertical_coord
    self
  end

  def rotate(rotation)
    return unless valid_rotation?(rotation)

    parsed_rotation = rotation.downcase
    direction_index = VALID_DIRECTIONS.index(direction)
    rotation_direction = parsed_rotation == 'right' ? 1 : -1
    self.direction = VALID_DIRECTIONS.rotate(rotation_direction)[direction_index]

    self
  end

  def next_movement
    horizontal_coord = self.horizontal_coord
    vertical_coord = self.vertical_coord

    if %w[north south].include?(direction)
      vertical_coord += next_movement_step
    else
      horizontal_coord += next_movement_step
    end

    [horizontal_coord, vertical_coord]
  end

  def coordinates
    [horizontal_coord, vertical_coord]
  end

  def status
    [horizontal_coord, vertical_coord, direction.upcase].join(', ')
  end

  private

  def valid_direction?(direction)
    VALID_DIRECTIONS.include?(direction&.downcase)
  end

  def valid_rotation?(rotation)
    VALID_ROTATIONS.include?(rotation&.downcase)
  end

  def invalid_direction_message
    "Invalid direction, valid directions are: #{VALID_DIRECTIONS.join(', ')}."
  end

  def next_movement_step
    return (DEFAULT_STEP * -1) if %w[south west].include?(direction)

    DEFAULT_STEP
  end
end
