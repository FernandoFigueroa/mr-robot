# frozen_string_literal: true

require 'spec_helper'

describe App do
  describe '.interactive' do
    it 'exits the loop when typing exit' do
      expect($stdout).to receive(:print).with("Please enter a valid command or type exit to stop\n")
      expect(Thor::LineEditor).to receive(:readline).with('What would you like the robot to do? ',
                                                          {}).and_return('exit')
      expect($stdout).to receive(:puts).with('', 'Bye')

      App.new.invoke(:interactive, [])
    end

    [SystemExit, Interrupt].each do |exception|
      it "handles the exception #{exception}" do
        expect($stdout).to receive(:print).with("Please enter a valid command or type exit to stop\n")
        expect(Thor::LineEditor).to receive(:readline).and_raise(exception)
        expect($stdout).to receive(:puts).with('', 'Bye')

        App.new.invoke(:interactive, [])
      end
    end

    context 'with valid commands' do
      it 'asks for commands and outputs controller messages' do
        expect($stdout).to receive(:print).with("Please enter a valid command or type exit to stop\n")
        expect(Thor::LineEditor).to receive(:readline).with('What would you like the robot to do? ',
                                                            {}).and_return('place 0,0,north')
        expect(Thor::LineEditor).to receive(:readline).with('What would you like the robot to do? ',
                                                            {}).and_return('report')
        expect($stdout).to receive(:print).with("0, 0, NORTH\n")
        expect(Thor::LineEditor).to receive(:readline).with('What would you like the robot to do? ',
                                                            {}).and_return('exit')
        expect($stdout).to receive(:puts).with('', 'Bye')

        App.new.invoke(:interactive, [])
      end
    end

    context 'with invalid commands' do
      it 'displays an invalid command message' do
        expect($stdout).to receive(:print).with("Please enter a valid command or type exit to stop\n")
        expect(Thor::LineEditor).to receive(:readline).with('What would you like the robot to do? ',
                                                            {}).and_return('invalid')
        expect($stdout).to receive(:print).with("Please enter a valid command.\n")
        expect(Thor::LineEditor).to receive(:readline).with('What would you like the robot to do? ',
                                                            {}).and_return('exit')
        expect($stdout).to receive(:puts).with('', 'Bye')

        App.new.invoke(:interactive, [])
      end
    end

    context 'when the command is ignored' do
      it 'displays an ignored command message when no robot has been placed' do
        expect($stdout).to receive(:print).with("Please enter a valid command or type exit to stop\n")
        expect(Thor::LineEditor).to receive(:readline).with('What would you like the robot to do? ',
                                                            {}).and_return('move')
        expect($stdout).to receive(:print).with("Command 'move' ignored.\n")
        expect(Thor::LineEditor).to receive(:readline).with('What would you like the robot to do? ',
                                                            {}).and_return('exit')
        expect($stdout).to receive(:puts).with('', 'Bye')

        App.new.invoke(:interactive, [])
      end

      it 'displays an ignored command message when attempting an invalid movement' do
        expect($stdout).to receive(:print).with("Please enter a valid command or type exit to stop\n")
        expect(Thor::LineEditor).to receive(:readline).with('What would you like the robot to do? ',
                                                            {}).and_return('place 0,0,west')
        expect(Thor::LineEditor).to receive(:readline).with('What would you like the robot to do? ',
                                                            {}).and_return('move')
        expect($stdout).to receive(:print).with("Command 'move' ignored.\n")
        expect(Thor::LineEditor).to receive(:readline).with('What would you like the robot to do? ',
                                                            {}).and_return('exit')
        expect($stdout).to receive(:puts).with('', 'Bye')

        App.new.invoke(:interactive, [])
      end

      it 'displays an ignored command message when attempting an invalid placement' do
        expect($stdout).to receive(:print).with("Please enter a valid command or type exit to stop\n")
        expect(Thor::LineEditor).to receive(:readline).with('What would you like the robot to do? ',
                                                            {}).and_return('place 8,0,west')
        expect($stdout).to receive(:print).with("Command 'place 8, 0, west' ignored.\n")
        expect(Thor::LineEditor).to receive(:readline).with('What would you like the robot to do? ',
                                                            {}).and_return('exit')
        expect($stdout).to receive(:puts).with('', 'Bye')

        App.new.invoke(:interactive, [])
      end
    end
  end

  describe '.import' do
    it 'loads a file with commands and execute them in order' do
      expect($stdout).to receive(:print).with("0, 1, NORTH\n")
      expect($stdout).to receive(:print).with("0, 0, WEST\n")
      expect($stdout).to receive(:print).with("3, 3, NORTH\n")

      App.new.invoke(:import, ['spec/fixtures/commands.txt'])
    end

    it 'ignores invalid commands' do
      expect($stdout).to_not receive(:print)

      App.new.invoke(:import, ['spec/fixtures/invalid_commands.txt'])
    end

    it 'handles invalid files' do
      expect($stdout).to receive(:puts).with('Looks like you entered an invalid file.')

      App.new.invoke(:import, ['spec/fixtures/not_exists'])
    end
  end
end
