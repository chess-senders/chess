# frozen_string_literal: true

FactoryBot.define do
  factory :knight do
    player nil
    row 0
    column 2
    type 'Knight'
    game_id { FactoryBot.build(:game) }
  end
end
