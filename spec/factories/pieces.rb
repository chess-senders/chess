FactoryBot.define do
  factory :piece do
    captured false
    player nil
    row 1
    column 1
    type 'Pawn'
    picture 'not_real'
    game_id { FactoryBot.build(:game).id }
  end
end
