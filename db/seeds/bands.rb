require 'csv'

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'bands.csv'

CSV.foreach(filepath, csv_options) do |row|
  # puts "#{row['Name']}, a #{row['Appearance']} beer from #{row['Origin']}"
  b = Thing.new
  b.name = row['artist_name']
  b.genre = row['artist_genre']
  b.category = 'Artist'
  b.save
  p "Created band #{b.name}"
end

