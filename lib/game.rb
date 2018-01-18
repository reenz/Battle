
class Game
  attr_reader :current_player

  def initialize(player_1,player_2)
    @players = [player_1, player_2]
    @current_player = player_1
  end

  def attack(player)
    player.reduce_points
  end

  def player_1
    @players[0]
  end

  def player_2
    @players[1]
  end

  def switch_turns
       @current_player = (@current_player == player_1)? player_2 : player_1 
   end

  # def switch_turns
  #     @current_player = opponent_of(current_player)
  # end
  #
  # def opponent_of(the_player)
  #   @players.select { |player| player != the_player }.first
  # end
end
