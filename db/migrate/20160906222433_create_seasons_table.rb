class CreateSeasonsTable < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :season
    end
  end
end
