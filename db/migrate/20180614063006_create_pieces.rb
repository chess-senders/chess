class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.boolean "captured?"
      t.integer "player_color"
      t.integer "row"
      t.integer "column"
      t.integer "type"
      t.integer "game_id"
      t.timestamps
    end
  end
end
