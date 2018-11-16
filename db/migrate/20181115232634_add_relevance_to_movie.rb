class AddRelevanceToMovie < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :relevance, :integer
  end
end
