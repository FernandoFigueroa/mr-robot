# frozen_string_literal: true

class Tabletop
  DEFAULT_UNITS = 5

  def initialize(height: DEFAULT_UNITS, width: DEFAULT_UNITS)
    @height = height
    @width = width
  end

  def valid_position?(horizontal_coord, vertical_coord)
    valid_horizontal_position?(horizontal_coord.to_i) && valid_vertical_position?(vertical_coord.to_i)
  end

  private

  def valid_horizontal_position?(horizontal_coord)
    horizontal_coord >= 0 && horizontal_coord < @width
  end

  def valid_vertical_position?(vertical_coord)
    vertical_coord >= 0 && vertical_coord < @height
  end
end
