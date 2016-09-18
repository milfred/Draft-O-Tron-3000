class AddStatusToRanking < ActiveRecord::Migration
  def change
    add_column :rankings, :status, :integer
  end
end
