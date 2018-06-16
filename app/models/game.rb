class Game < ApplicationRecord
  enum state: [
    'Waiting for players',
    "White's Turn",
    "Black's Turn",
    'Black Won',
    'White Won'
  ]

  belongs_to :white_player_id, class_name: :Player
  belongs_to :black_player_id, class_name: :Player
  has_many :pieces
end
