class ChangeMovedToMoves < ActiveRecord::Migration[5.0]
  def change
    remove_column :pieces, :moved
    add_column :pieces, :moves, :integer, default: 0
  end
end
