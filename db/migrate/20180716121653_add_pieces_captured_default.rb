class AddPiecesCapturedDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :pieces, :captured, from: nil, to: false
  end
end
