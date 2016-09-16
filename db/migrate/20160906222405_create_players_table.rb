class CreatePlayersTable < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :api_player_id
      t.string :name
      t.string :team
      t.string :position
      t.integer :experience
      t.boolean :active
      t.string :photo_url
      t.integer :bye_week
      t.integer :depth_order
      t.integer :draft_round
      t.integer :draft_pick
      t.string :rotowire_url
      t.float :adp
      t.float :adp_ppr

      t.timestamps null: false
    end
  end
end
