class Game

  attr_reader :current_player, :opponent, :player_1, :player_2

  def initialize(player_1, player_2)
    @current_player = player_1
    @opponent = player_2
    @player_1 = player_1
    @player_2 = player_2
  end

  def attack
     @opponent.reduce_points
  end

  def switch_turns
      @current_player, @opponent = @opponent, @current_player
   end

   def game_over?
     @opponent.hit_points <= 0
   end
end

  # def switch_turns
  #     @current_player = opponent_of(current_player)
  # end
  #
  # def opponent_of(the_player)
  #   @players.select { |player| player != the_player }.first
  # end
