class AddPicUrlToMovie < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :pic_url, :string
  end
end

