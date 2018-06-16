class AddIndexToGame < ActiveRecord::Migration[5.0]
  def change
    add_index :games, [:white_player_id, :black_player_id]
  end
end
