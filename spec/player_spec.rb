require 'player'

describe 'Player' do
  subject(:player) {Player.new('Reena')}

  describe '#name' do
    it 'returns name' do
      expect(player.name).to eq 'Reena'
    end
  end

  describe '#reduce_points' do
    it 'reduces HP points by 10' do
      expect(player.reduce_points).to eq 50
    end
  end
end
