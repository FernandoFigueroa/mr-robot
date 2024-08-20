# frozen_string_literal: true

require_relative('../../lib/tabletop')

describe Tabletop do
  let(:tabletop) { described_class.new }

  describe '#valid_position?' do
    it 'returns true if the position is valid' do
      expect(tabletop.valid_position?(4, 1)).to eq(true)
    end

    it 'returns false if the horizontal position is invalid' do
      expect(tabletop.valid_position?(5, 1)).to eq(false)
    end

    it 'returns false if the vertical position is invalid' do
      expect(tabletop.valid_position?(0, 5)).to eq(false)
    end

    context 'with different tabletop size' do
      let(:tabletop) { described_class.new(height: 50, width: 50) }

      it { expect(tabletop.valid_position?(49, 49)).to eq(true) }
    end
  end
end
