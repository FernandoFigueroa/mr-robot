# frozen_string_literal: true

require_relative('../../lib/robot')

describe Robot do
  let(:horizontal_coord) { 4 }
  let(:vertical_coord) { 1 }
  let(:direction) { 'north' }
  let(:robot) { described_class.new(horizontal_coord, vertical_coord, direction) }

  context 'with valid coordinates' do
    it { expect(robot.horizontal_coord).to eq(4) }
    it { expect(robot.vertical_coord).to eq(1) }
    it { expect(robot.direction).to eq('north') }
  end

  context 'with invalid direction' do
    let(:direction) { 'invalid' }

    it {
      expect do
        robot
      end.to raise_error(ArgumentError, 'Invalid direction, valid directions are: north, east, south, west.')
    }
  end

  describe '#move' do
    let(:horizontal_coord) { 3 }
    let(:vertical_coord) { 1 }
    let(:direction) { 'west' }

    context 'when attempting a valid horizontal movement west' do
      before do
        robot.move
      end

      it { expect(robot.horizontal_coord).to eq(2) }
      it { expect(robot.vertical_coord).to eq(1) }
    end

    context 'when attempting a valid horizontal movement east' do
      let(:direction) { 'east' }

      before do
        robot.move
      end

      it { expect(robot.horizontal_coord).to eq(4) }
      it { expect(robot.vertical_coord).to eq(1) }
    end

    context 'when attempting a valid vertical movement north' do
      let(:direction) { 'north' }

      before do
        robot.move
      end

      it { expect(robot.horizontal_coord).to eq(3) }
      it { expect(robot.vertical_coord).to eq(2) }
    end

    context 'when attempting a valid vertical movement south' do
      let(:direction) { 'south' }

      before do
        robot.move
      end

      it { expect(robot.horizontal_coord).to eq(3) }
      it { expect(robot.vertical_coord).to eq(0) }
    end
  end

  describe '#status' do
    it 'returns a formatted message with the robot position and direction' do
      expect(robot.status).to eq('4, 1, NORTH')
    end
  end

  describe '#rotate' do
    let(:rotation_direction) { 'left' }
    let(:rotated_robot) { robot.rotate(rotation_direction) }

    context 'when the robot is facing north' do
      context 'when rotating to the left' do
        it { expect(rotated_robot.direction).to eq('west') }
      end

      context 'when rotating to the right' do
        let(:rotation_direction) { 'right' }

        it { expect(rotated_robot.direction).to eq('east') }
      end
    end

    context 'when the robot is facing west' do
      let(:direction) { 'west' }

      context 'when rotating to the left' do
        it { expect(rotated_robot.direction).to eq('south') }
      end

      context 'when rotating to the right' do
        let(:rotation_direction) { 'right' }

        it { expect(rotated_robot.direction).to eq('north') }
      end
    end

    context 'when the robot is facing south' do
      let(:direction) { 'south' }

      context 'when rotating to the left' do
        it { expect(rotated_robot.direction).to eq('east') }
      end

      context 'when rotating to the right' do
        let(:rotation_direction) { 'right' }

        it { expect(rotated_robot.direction).to eq('west') }
      end
    end

    context 'when the robot is facing east' do
      let(:direction) { 'east' }

      context 'when rotating to the left' do
        it { expect(rotated_robot.direction).to eq('north') }
      end

      context 'when rotating to the right' do
        let(:rotation_direction) { 'right' }

        it { expect(rotated_robot.direction).to eq('south') }
      end
    end
  end
end
