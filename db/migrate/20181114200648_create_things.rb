class CreateThings < ActiveRecord::Migration[5.2]
  def change
    create_table :things do |t|
      t.string :name
      t.string :genre
      t.string :category

      t.timestamps
    end
  end
end
