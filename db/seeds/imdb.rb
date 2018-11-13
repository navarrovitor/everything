require 'csv'

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'topimdb.csv'

CSV.foreach(filepath, csv_options) do |row|
  # puts "#{row['Name']}, a #{row['Appearance']} beer from #{row['Origin']}"
  m = Movie.new
  m.title = row['moviename']
  m.save
  p "Created movie #{m.title}"
end

