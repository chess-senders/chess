class AddIndexToGame < ActiveRecord::Migration[5.0]
  def change
    add_index :games, %i[white_player_id black_player_id]
  end
end
