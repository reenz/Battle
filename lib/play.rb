class Play < Game

  def self.create(player_1,player_2)
    @play = Game.new(player_1,player_2)
  end

  def self.instance
    @play
  end

end
