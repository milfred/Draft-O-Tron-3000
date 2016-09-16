class CreateSeasonsTable < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :season

      t.timestamps null: false
    end
  end
end
