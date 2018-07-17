FactoryBot.define do
  factory :rook do
    captured false
    player nil
    row 7
    column 7
    type 'Rook'
    game_id { FactoryBot.build(:game) }
  end
end
