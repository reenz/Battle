require 'sinatra/base'
require 'securerandom'
require_relative 'lib/player'
require_relative 'lib/game'

class Battle < Sinatra::Base
  secret = ENV['SESSION_SECRET']
  if secret.nil? || secret.bytesize < 64
    raise 'Set SESSION_SECRET to at least 64 random bytes' if environment == :production
    secret = SecureRandom.hex(64)
  end
  set :session_secret, secret
  set :sessions, key: 'battle.session', httponly: true, same_site: :lax,
                 secure: environment == :production, expire_after: 86_400

  helpers do
    def h(value)
      Rack::Utils.escape_html(value.to_s)
    end

    def csrf_token
      session[:csrf_token] ||= SecureRandom.hex(32)
    end

    def restore_game
      data = session[:battle]
      return unless data
      game = Game.new(Player.new(data['names'][0], data['hp'][0]), Player.new(data['names'][1], data['hp'][1]))
      game.switch_turns if data['turn'] == 1
      game
    end
  end

  before do
    if request.post? && !Rack::Utils.secure_compare(csrf_token, params['csrf_token'].to_s)
      halt 403, 'Invalid form token'
    end
    @game = restore_game
    redirect '/' if !@game && !['/', '/names'].include?(request.path_info)
  end

  after do
    if @game
      session[:battle] = {
        'names' => [@game.player_1.name, @game.player_2.name],
        'hp' => [@game.player_1.hit_points, @game.player_2.hit_points],
        'turn' => @game.current_player.equal?(@game.player_1) ? 0 : 1
      }
    end
  end

  get('/') { erb :index }

  post '/names' do
    names = [params[:player_1_name], params[:player_2_name]]
    halt 400, 'Enter two names of 1–80 characters' unless names.all? { |name| name.is_a?(String) && name.strip.length.between?(1, 80) }
    @game = Game.new(Player.new(names[0].strip), Player.new(names[1].strip))
    redirect '/play'
  end

  get('/play') { erb :play }

  post '/attack' do
    @game.attack
    if @game.game_over?
      redirect '/game_over'
    else
      erb :attack
    end
  end

  post '/switch-turns' do
    @game.switch_turns
    redirect '/play'
  end

  get('/game_over') { erb :game_over }
  run! if app_file == $0
end
