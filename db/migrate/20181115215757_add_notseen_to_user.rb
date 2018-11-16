class AddNotseenToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :not_seen, :integer, array: true, default: []
  end
end
