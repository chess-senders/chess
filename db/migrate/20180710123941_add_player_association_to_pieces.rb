class AddPlayerAssociationToPieces < ActiveRecord::Migration[5.0]
  def change
    remove_column :pieces, :player_color
    add_reference :pieces, :player, index: true
  end
end
