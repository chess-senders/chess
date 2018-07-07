# require_relative 'players'

FactoryBot.define do
  factory :game do
    name 'Game ON!'
    white_player_id { FactoryBot.build(:player).id }
    black_player_id { FactoryBot.build(:player).id }
    state 'Waiting for players'
  end
end
