require 'rack/test'

describe 'Session and request security' do
  def browser
    Rack::Test::Session.new(Rack::MockSession.new(Battle))
  end

  def start_game(client, first, second)
    client.get('/')
    token = client.last_response.body.match(/name="csrf_token" value="([^"]+)"/)[1]
    client.post('/names', player_1_name: first, player_2_name: second, csrf_token: token)
    expect(client.last_response.status).to eq(302)
    client.follow_redirect!
    token
  end

  it 'keeps games isolated between independent session cookies' do
    alice = browser
    bob = browser
    token = start_game(alice, 'Alice', 'Ann')
    start_game(bob, 'Bob', 'Bea')
    alice.post('/attack', csrf_token: token)
    expect(alice.last_response.status).to eq(200)
    alice.get('/play')
    expect(alice.last_response.body).to include('Ann: 50HP')
    expect(alice.last_response.body).not_to include('Bob')
    bob.get('/play')
    expect(bob.last_response.body).to include('Bea: 60HP')
    expect(bob.last_response.body).not_to include('Alice')
  end

  it 'rejects forged POSTs and GET attacks without changing game state' do
    client = browser
    start_game(client, 'Alice', 'Ann')
    client.post('/attack')
    expect(client.last_response.status).to eq(403)
    client.get('/attack')
    expect(client.last_response.status).to eq(404)
    client.get('/play')
    expect(client.last_response.body).to include('Ann: 60HP')
  end

  it 'renders player names as text on play and attack pages' do
    client = browser
    token = start_game(client, '<script>alert(1)</script>', 'Ann')
    expect(client.last_response.body).to include('&lt;script&gt;alert(1)&lt;/script&gt;')
    expect(client.last_response.body).not_to include('<script>alert(1)</script>')
    client.post('/attack', csrf_token: token)
    expect(client.last_response.body).to include('&lt;script&gt;alert(1)&lt;/script&gt;')
    expect(client.last_response.body).not_to include('<script>alert(1)</script>')
  end
end
