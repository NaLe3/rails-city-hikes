class AddAvgRatingToRoute < ActiveRecord::Migration[5.2]
  def change
    add_column :routes, :avg_rating, :float, default: 0
  end
end
