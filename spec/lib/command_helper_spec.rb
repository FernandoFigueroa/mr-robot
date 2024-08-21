# frozen_string_literal: true

require_relative('../../lib/command_helper')

describe CommandHelper do
  describe '.parse_command' do
    it 'parses a valid place command' do
      expect(described_class.parse_command('PLACE 1,0,north')).to eq(['place', %w[1 0 north]])
    end

    it 'returns nil for invalid place commands' do
      expect(described_class.parse_command('PLACE 1, 0,north')).to be_nil
    end

    %w[move LEFT right Report exit].each do |command|
      it "returns true for a valid #{command.downcase} command" do
        expect(described_class.parse_command(command)).to eq([command.downcase])
      end
    end

    it 'returns nil for an invalid command' do
      expect(described_class.parse_command('invalid')).to eq(nil)
    end

    it 'returns nil for an empty command' do
      expect(described_class.parse_command('')).to eq(nil)
    end

    it 'handles nil values' do
      expect(described_class.parse_command(nil)).to eq(nil)
    end
  end

  describe '.valid_command?' do
    it 'returns true with a valid place command' do
      expect(described_class.valid_command?('PLACE 1,0,north')).to eq(true)
    end

    it 'returns false with an invalid place command' do
      expect(described_class.valid_command?('PLACE 1,invalid,north')).to eq(false)
    end

    %w[move LEFT right report exit].each do |command|
      it "returns true for a valid #{command} command" do
        expect(described_class.valid_command?(command)).to eq(true)
      end
    end

    it 'returns false for an invalid command' do
      expect(described_class.valid_command?('invalid')).to eq(false)
    end

    it 'returns false for an empty command' do
      expect(described_class.valid_command?('')).to eq(false)
    end

    it 'handles nil values' do
      expect(described_class.valid_command?(nil)).to eq(false)
    end
  end
end
