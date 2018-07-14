class AddColumnToPiece < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :picture, :string
  end
end
