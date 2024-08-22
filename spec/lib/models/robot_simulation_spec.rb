# frozen_string_literal: true

require_relative('../../../lib/models/robot_simulation')
require_relative('../../../lib/models/robot')

describe RobotSimulation do
  let(:robot_simulation) { described_class.new }

  describe '#place_robot' do
    let(:horizontal_coord) { 4 }
    let(:vertical_coord) { 1 }
    let(:direction) { 'north' }
    let(:robot) { robot_simulation.place_robot(horizontal_coord, vertical_coord, direction) }

    context 'with valid position' do
      it { expect(robot).to be_a Robot }
      it { expect(robot.horizontal_coord).to eq(4) }
      it { expect(robot.vertical_coord).to eq(1) }
      it { expect(robot.direction).to eq('north') }
    end

    context 'with invalid horizontal position' do
      let(:horizontal_coord) { 5 }

      it { expect(robot).to be_nil }
    end

    context 'with invalid vertical position' do
      let(:vertical_coord) { 5 }

      it { expect(robot).to be_nil }
    end

    context 'with invalid direction' do
      let(:direction) { 'invalid' }

      it { expect(robot).to be_nil }
    end
  end

  describe '#move_robot' do
    context 'when no robot has been placed' do
      it { expect(robot_simulation.move_robot).to be_nil }
    end

    context 'when a robot has been placed and has a valid movement' do
      before do
        robot_simulation.place_robot(0, 0, 'east')
      end

      it 'moves the robot to the right direction' do
        robot = robot_simulation.move_robot
        expect(robot.coordinates).to eq([1, 0])
      end
    end

    context 'when a robot has been placed and has no available movement' do
      before do
        robot_simulation.place_robot(0, 0, 'west')
      end

      it { expect(robot_simulation.move_robot).to be_nil }
    end
  end

  describe '#robot_status' do
    context 'when no robot has been placed' do
      it { expect(robot_simulation.robot_status).to be_nil }
    end

    context 'when a robot has been placed' do
      before do
        robot_simulation.place_robot(0, 0, 'east')
      end

      it { expect(robot_simulation.robot_status).to eq('0, 0, EAST') }
    end
  end

  describe '#rotate_robot' do
    context 'when no robot has been placed' do
      it { expect(robot_simulation.rotate_robot('left')).to be_nil }
    end

    context 'when a robot has been placed' do
      let(:robot) { robot_simulation.rotate_robot('left') }
      before do
        robot_simulation.place_robot(0, 0, 'east')
      end

      it { expect(robot).to be_a Robot }
      it { expect(robot.horizontal_coord).to eq(0) }
      it { expect(robot.vertical_coord).to eq(0) }
      it { expect(robot.direction).to eq('north') }
    end
  end
end
