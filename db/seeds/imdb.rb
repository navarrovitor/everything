require 'csv'

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'topimdb.csv'

CSV.foreach(filepath, csv_options) do |row|
  title = row['moviename']

  movie_titles = []
  Movie.all.each do |movie|
    movie_titles << movie.title
  end

  if !movie_titles.include?(title)
    m = Movie.new
    m.title = title
    m.save
    p "Populated movie: #{title}"
  else
    p "Movie #{title} already exists on database"
  end
end

