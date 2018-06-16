class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.boolean :captured
      t.integer :player_color
      t.integer :row
      t.integer :column
      t.integer :type
      t.belongs_to :game, index: true

      t.timestamps
    end
  end
end
