class AddRatingToMovie < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :rating, :integer
  end
end
