class RemoveWrongTypeFromPiece < ActiveRecord::Migration[5.0]
  def change
    remove_column :pieces, :type, :integer
  end
end
