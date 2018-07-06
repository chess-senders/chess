FactoryBot.define do
  factory :king do
    captured false
    player_color nil
    row 3
    column 2
    type 'King'
    game_id { FactoryBot.build(:game).id }
  end
end
