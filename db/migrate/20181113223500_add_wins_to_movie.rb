class AddWinsToMovie < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :battles_won, :integer, default: 0
  end
end
