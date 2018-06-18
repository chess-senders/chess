FactoryBot.define do
  factory :game do
    name 'Game ON!'
    white_player_id nil
    black_player_id nil
    state 'Waiting for players'
  end
end
