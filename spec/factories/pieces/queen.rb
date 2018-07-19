FactoryBot.define do
  factory :queen do
    captured false
    player nil
    row 0
    column 4
    type 'Queen'
    game_id { FactoryBot.build(:game) }
  end
end
