class AddGameStateDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:games, :state, 'Waiting for players')
  end
end
