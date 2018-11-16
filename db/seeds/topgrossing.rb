# Scrape 250 IMDB movies

require 'open-uri'
require 'nokogiri'

url = "https://rateyourmusic.com/list/abyss89/the_100_highest_grossing_movies_of_all_time_worldwide/"

html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)

html_doc.search('.list_user a').each do |element|
  title = element.text.strip

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

