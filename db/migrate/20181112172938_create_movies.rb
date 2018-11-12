class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.string :director
      t.string :actors, array: true, default: []
      t.integer :length

      t.timestamps
    end
  end
end
