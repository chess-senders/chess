class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.boolean "captured?"
      t.boolean "color"
      t.integer "row"
      t.integer "column"
      t.integer "name"
      t.integer "game_id"
      t.timestamps
    end
  end
end
