require 'player'

describe 'Player' do
  subject(:player) {Player.new('Reena')}

  describe '#name' do
    it 'returns name' do
      expect(player.name).to eq 'Reena'
    end
  end
end
