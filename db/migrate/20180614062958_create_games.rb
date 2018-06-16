class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer 'white_player'
      t.integer 'black_player'
      t.integer 'state'
      t.timestamps
    end
  end
end
