FactoryBot.define do
  factory :piece do
    captured false
    player_color nil
    row 2
    column 1
    type 'Pawn'
    game_id { FactoryBot.build(:game).id }
  end
end
