class ChangePlayernameUniq < ActiveRecord::Migration[5.0]
  def change
    remove_index :players, :playername
    add_index(:players, :playername, unique: false, name: 'index_players_on_playername')
  end
end
