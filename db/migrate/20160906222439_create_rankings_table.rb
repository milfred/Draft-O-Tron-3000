class CreateRankingsTable < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :sheet_id
      t.integer :player_id
      t.integer :player_rank
    end
  end
end
