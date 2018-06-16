class RemoveUsernameFromPlayers < ActiveRecord::Migration[5.0]
  def change
    remove_column :players, :username
  end
end
