

describe Game do
  subject(:game) { described_class.new(player_1, player_2) }
  let(:player_1) { double :player }
  let(:player_2) { double :player }

  describe '#attack' do
    it "checks if games recieves reduce_points" do
      expect(player_2).to receive(:reduce_points)
      game.attack(player_2)
    end
  end

 describe '#player_1' do
    it "player_1"do
      expect(game.player_1).to eq player_1
    end
  end

   describe '#player_2' do
    it "player_2 "do
      expect(game.player_1).to eq player_1
    end
  end

  describe '#current_player' do
    it 'returns the current_player' do
      expect(game.current_player).to eq player_1
    end
  end

  describe '#switch_turns' do
    it 'switches the current_player' do
      game.switch_turns
      expect(game.current_player).to eq player_2
    end

  end
end
