class CreateMeasurablesTable < ActiveRecord::Migration
  def change
    create_table :measurables do |t|
      t.integer :player_id
      t.integer :season_id
      t.integer :games_played
      t.integer :games_started
      t.integer :pass_yards
      t.integer :pass_tds
      t.integer :interceptions
      t.integer :pass_2pt_conv
      t.integer :rush_yards
      t.integer :rush_tds
      t.integer :rush_2pt_conv
      t.integer :receptions
      t.integer :receive_yards
      t.integer :receive_tds
      t.integer :receive_2pt_conv
      t.integer :fumbles
      t.integer :fumbles_lost

      t.timestamps null: false
    end
  end
end
