require 'sinatra'
require './lib/player'
require './lib/game'
require './lib/play'

class Battle < Sinatra::Base
  enable :sessions

before do
  @game = Play.instance
end
  get '/' do
    erb :index
  end

  post '/names' do
    player_1 = Player.new(params[:player_1_name])
    player_2 = Player.new(params[:player_2_name])
    @game = Play.create(player_1, player_2)
    redirect '/play'
  end

  get '/play' do
    erb :play
  end

  get '/attack' do
    @game.attack
    if @game.game_over?
      redirect 'game_over'
    else
      erb :attack
    end
  end

  get '/switch-turns' do
    @game.switch_turns
    redirect('/play')
  end

  get '/game_over' do
    erb :game_over
  end

  run! if app_file == $0
end
