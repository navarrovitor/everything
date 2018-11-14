require 'csv'

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'movies.csv'

CSV.foreach(filepath, csv_options) do |row|
  # puts "#{row['Name']}, a #{row['Appearance']} beer from #{row['Origin']}"
  m = Thing.new
  m.name = row['movie_name']
  m.genre = row['genre']
  m.category = 'Movie'
  m.save
  p "Created movie #{m.name}"
end
