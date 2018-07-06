FactoryBot.define do
  factory :bishop do
    captured false
    player_color nil
    row 1
    column 7
    type 'Bishop'
    game_id { FactoryBot.build(:game).id }
  end
end
