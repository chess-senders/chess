class Game < ApplicationRecord
  enum state ['Waiting for players', "White's Turn", "Black's Turn", 'Black Won', 'White Won']
  has_many :pieces
  belongs_to :black_player_id, class_name: "Player"
  belongs_to :white_player_id, class_name: "Player"
end
