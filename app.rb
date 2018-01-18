require 'sinatra'
require './lib/player'
require './lib/game'

class Battle < Sinatra::Base
  enable :sessions

  get '/' do
    erb :index
  end

  post '/names' do
    player_1 = Player.new(params[:player_1_name])
    player_2 = Player.new(params[:player_2_name])
    $game = Game.new(player_1, player_2)
    redirect '/play'
  end

  get '/play' do
    @game = $game
    erb :play
  end

  get '/attack' do
    @game = $game
    @game.attack
    if @game.game_over?
      redirect 'game_over'
    else
      erb :attack
    end
  end

  get '/switch-turns' do
    $game.switch_turns
    redirect('/play')
  end

  get '/game_over' do
    @game = $game
    erb :game_over
  end

  run! if app_file == $0
end
