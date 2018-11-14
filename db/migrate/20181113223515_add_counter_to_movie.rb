class AddCounterToMovie < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :battles_total, :integer, default: 0
  end
end
