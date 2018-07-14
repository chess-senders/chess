class AddPiecesToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_reference :players, :pieces, index: true
  end
end
