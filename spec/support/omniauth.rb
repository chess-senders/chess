def omniauth_stub(opts = {})
  default = {
    provider: opts[:provider],
    uid: '1234',
    opts[:provider] => {
      email: 'foobar@example.com',
      playername: 'Carl'
    }
  }

  credentials = default.merge(opts)
  provider = credentials[:provider]
  user_hash = credentials[provider]

  stub = OmniAuth::AuthHash.new(
    'provider' => provider,
    'uid' => credentials[:uid],
    'info' => {
      'email' => user_hash[:email],
      'playername' => user_hash[:player_name]
    }
  )

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[provider] = stub
end
