# Movie Example: Back to the Future

m = Movie.new
m.title = "Back to the Future"
m.year = 1985
m.director = "Zemeckis"
m.actors << "Michael J Fox"
m.actors << "Christopher Lloyd"
m.length = 116
m.save

puts "Created movie: #{m.title}"
