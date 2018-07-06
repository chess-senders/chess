FactoryBot.define do
  factory :rook do
    captured false
    player_color nil
    row 8
    column 8
    type 'Rook'
    game_id { FactoryBot.build(:game).id }
  end
end
