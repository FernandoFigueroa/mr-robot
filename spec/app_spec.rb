# frozen_string_literal: true

require 'spec_helper'

describe App do
  # https://github.com/rails/thor/blob/a43d92fad7ebd77d359b7b96eb3db8a73ef9057c/spec/shell/basic_spec.rb#L48
  describe '.interactive' do
    it 'exists the loop when typing exit' do
      expect(Thor::LineEditor).to receive(:readline).with('Please enter a valid command or type exit to stop ',
                                                          {}).and_return('exit')
      expect($stdout).to receive(:puts).with('', 'Bye')

      App.new.invoke(:interactive, [])
    end

    [SystemExit, Interrupt].each do |exception|
      it "handles the exception #{exception}" do
        expect(Thor::LineEditor).to receive(:readline).and_raise(exception)
        expect($stdout).to receive(:puts).with('', 'Bye')

        App.new.invoke(:interactive, [])
      end
    end

    context 'with valid commands' do
      it 'asks for commands and outputs controller messages' do
        expect(Thor::LineEditor).to receive(:readline).with('Please enter a valid command or type exit to stop ',
                                                            {}).and_return('place 0,0,north')
        expect(Thor::LineEditor).to receive(:readline).with('Please enter a valid command or type exit to stop ',
                                                            {}).and_return('report')
        expect($stdout).to receive(:print).with("0, 0, NORTH\n")
        expect(Thor::LineEditor).to receive(:readline).with('Please enter a valid command or type exit to stop ',
                                                            {}).and_return('exit')
        expect($stdout).to receive(:puts).with('', 'Bye')

        App.new.invoke(:interactive, [])
      end
    end

    context 'with invalid commands' do
      it 'displays an invalid command message' do
        expect(Thor::LineEditor).to receive(:readline).with('Please enter a valid command or type exit to stop ',
                                                            {}).and_return('invalid')
        expect($stdout).to receive(:print).with("Invalid command\n")
        expect(Thor::LineEditor).to receive(:readline).with('Please enter a valid command or type exit to stop ',
                                                            {}).and_return('exit')
        expect($stdout).to receive(:puts).with('', 'Bye')

        App.new.invoke(:interactive, [])
      end
    end
  end
end
