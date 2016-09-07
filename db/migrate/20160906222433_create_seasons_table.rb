class CreateSeasonsTable < ActiveRecord::Migration
  def change
    t.integer :season
  end
end
