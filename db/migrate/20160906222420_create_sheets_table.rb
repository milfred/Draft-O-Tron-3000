class CreateSheetsTable < ActiveRecord::Migration
  def change
    create_table :sheets do |t|
      t.string :url_parameter
      t.float :pass_yard_pts
      t.float :pass_td_pts
      t.float :int_pts
      t.float :rush_yard_pts
      t.float :rush_td_pts
      t.float :rec_pts
      t.float :rec_yard_pts
      t.float :rec_td_pts
      t.float :avg_qb_proj
      t.float :avg_rb_proj
      t.float :avg_wr_proj
      t.float :avg_te_proj
    end
  end
end
