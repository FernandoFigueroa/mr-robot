require_relative('../../../lib/controllers/games_controller')

describe GamesController do
  let(:controller) { described_class.new }

  it 'gracefully handles invalid commands' do
    expect(controller.wrong).to eq('Invalid action wrong')
  end

  describe '#place' do
    it 'returns a robot when the place is succesfull' do
      expect(controller.place('0', '0', 'North')).to be_a Robot
    end

    context 'with invalid arguments' do
      it 'returns nil when the placing fails' do
        expect(controller.place(-1, '0', 'North')).to be_nil
      end
    end
  end

  describe '#move' do
    context 'with a placed robot' do
      before do
        controller.place('0', '0', 'North')
      end

      it 'returns a robot when the movement is succesfull' do
        expect(controller.move).to be_a Robot
      end

      context 'with an invalid movement' do
        before do
          controller.left
        end

        it 'returns nil when the movement fails' do
          expect(controller.move).to be_nil
        end
      end
    end

    context 'without a placed robot' do
      it 'returns nil when there is no robot' do
        expect(controller.move).to be_nil
      end
    end
  end


  describe '#left' do
    context 'with a placed robot' do
      before do
        controller.place('0', '0', 'North')
      end

      it 'returns a robot when the rotation is succesfull' do
        expect(controller.left).to be_a Robot
      end
    end

    context 'without a placed robot' do
      it 'returns nil when there is no robot' do
        expect(controller.left).to be_nil
      end
    end
  end

  describe '#right' do
    context 'with a placed robot' do
      before do
        controller.place('0', '0', 'North')
      end

      it 'returns a robot when the rotation is succesfull' do
        expect(controller.right).to be_a Robot
      end
    end

    context 'without a placed robot' do
      it 'returns nil when there is no robot' do
        expect(controller.right).to be_nil
      end
    end
  end

  describe '#report' do
    context 'with a placed robot' do
      before do
        controller.place('0', '0', 'North')
      end

      it 'returns a message with the robot status' do
        expect(controller.report).to eq('0, 0, NORTH')
      end
    end

    context 'without a placed robot' do
      it 'returns nil when there is no robot' do
        expect(controller.report).to be_nil
      end
    end
  end
end
