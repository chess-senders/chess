class Game < ApplicationRecord
  enum state: [
    'Waiting for players',
    "White's Turn",
    "Black's Turn",
    'Black Won',
    'White Won'
  ]

  has_many :pieces

end
