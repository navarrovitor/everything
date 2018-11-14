class CreatePoints < ActiveRecord::Migration[5.2]
  def change
    create_table :points do |t|
      t.integer :points, default: 0
      t.references :user, foreign_key: true
      t.references :thing, foreign_key: true

      t.timestamps
    end
  end
end
