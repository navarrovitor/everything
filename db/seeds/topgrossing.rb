# Scrape 250 IMDB movies

require 'open-uri'
require 'nokogiri'

url = "https://rateyourmusic.com/list/abyss89/the_100_highest_grossing_movies_of_all_time_worldwide/"

html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)

html_doc.search('.list_user a').each do |element|
  m = Movie.new
  m.title = element.text.strip
  m.save
  p "Populated movie: #{m.title}"
end

