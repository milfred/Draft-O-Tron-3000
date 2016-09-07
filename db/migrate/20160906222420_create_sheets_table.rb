class CreateSheetsTable < ActiveRecord::Migration
  def change
    create_table :sheets do |t|
      t.string :url_parameter
      t.float :pass_yard_pts
      t.float :pass_td_pts
      t.float :int_pts
      t.float :run_yard_pts
      t.float :run_td_pts
      t.float :rec_pts
      t.float :rec_yard_pts
      t.float :rec_td_pts
    end
  end
end
