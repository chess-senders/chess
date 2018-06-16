class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :white_player_id
      t.integer :black_player_id
      t.integer :state

      t.timestamps
    end
  end
end
