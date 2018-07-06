FactoryBot.define do
  factory :king do
    captured false
    player_color nil
    row 3
    column 3
    type 'King'
    game_id { FactoryBot.build(:game) }
  end
end
