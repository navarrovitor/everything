# Movie Example: Back to the Future

m = Movie.new
m.title = "Back to the Future"
m.year = 1985
m.director = "Zemeckis"
m.actors << "Michael J Fox"
m.actors << "Christopher Lloyd"
m.length = 116
m.pic_url = "http://www.vortexcultural.com.br/images/2015/10/back-to-the-future-banner.jpg"
m.save

puts "Created movie: #{m.title}"

p = Point.new
p.user_id = 1
p.movie = Movie.last
p.points = 7
p.save

puts "Created rating for #{p.movie.title}"

m = Movie.new
m.title = "Harry Potter and the Sorcerer's Stone"
m.year = 2001
m.director = "Chris Columbus"
m.actors << "Daniel Radcliffe"
m.actors << "Emma Watson"
m.actors << "Rupert Grint"
m.length = 159
m.pic_url = "http://www.hollywood.tv/wp-content/uploads/2017/06/harry-potter-sorcerers-stone-poster-kodi.jpg"
m.save

puts "Created movie: #{m.title}"

p = Point.new
p.user_id = 1
p.movie = Movie.last
p.points = 8
p.save

puts "Created rating for #{p.movie.title}"

m = Movie.new
m.title = "Harry Potter and the Chamber of Secrets"
m.year = 2001
m.director = "Chris Columbus"
m.actors << "Daniel Radcliffe"
m.actors << "Emma Watson"
m.actors << "Rupert Grint"
m.length = 159
m.pic_url = "https://www.musicalfundsociety.org/wp-content/uploads/2017/04/17308789_10154874843740210_298048721314539839_n.jpg"
m.save

puts "Created movie: #{m.title}"

p = Point.new
p.user_id = 1
p.movie = Movie.last
p.points = 5
p.save

puts "Created rating for #{p.movie.title}"

m = Movie.new
m.title = "Inception"
m.year = 2010
m.director = "Christopher Nolan"
m.actors << "DiCaprio"
m.actors << "Watanabe"
m.actors << "Ellen Page"
m.length = 148
m.pic_url = "https://resizing.flixster.com/KgUj6WxcUFCjq1bYP-x3ExELnYw=/206x305/v1.bTsxMTE2NjcyNTtqOzE3OTQ5OzEyMDA7ODAwOzEyMDA"
m.save

puts "Created movie: #{m.title}"

m = Movie.new
m.title = "Wolf of Wall Street"
m.year = 2013
m.director = "Martin Scorsese"
m.actors << "DiCaprio"
m.actors << "Jonah Hill"
m.length = 180
m.pic_url = "https://cdn.newsapi.com.au/image/v1/f3a3cbe87446b349b9751b5fe1a8457b"
m.save

puts "Created movie: #{m.title}"

m = Movie.new
m.title = "Jurassic Park"
m.year = 1993
m.director = "Spielberg"
m.actors << "Sam Neill"
m.actors << "Laura Dern"
m.length = 126
m.pic_url = "https://i2.wp.com/s3.amazonaws.com/cloud.estacaonerd.com/wp-content/uploads/2018/06/12112903/rah_33656994729.jpg?fit=1280\%2C720&ssl=1"
m.save

puts "Created movie: #{m.title}"

m = Movie.new
m.title = "Westworld"
m.year = 1973
m.director = "Chrichton"
m.actors << "Yul Brynner"
m.actors << "James Brolin"
m.length = 88
m.pic_url = "https://nerdist.com/wp-content/uploads/2016/10/Westword-movie-100316.jpg"
m.save

puts "Created movie: #{m.title}"

m = Movie.new
m.title = "Matrix"
m.year = 1999
m.director = "Lilly & Lana Wachowski"
m.actors << "Reeves"
m.actors << "Fishburne"
m.length = 136
m.pic_url = "https://images-na.ssl-images-amazon.com/images/I/51vpnbwFHrL._SY445_.jpg"
m.save

puts "Created movie: #{m.title}"

m = Movie.new
m.title = "Frozen"
m.year = 2013
m.director = "Buck & Lee"
m.actors << "Kristen Bell"
m.actors << "Groff"
m.length = 109
m.pic_url = "https://images-na.ssl-images-amazon.com/images/I/51vgOCNPn3L.jpg"
m.save

puts "Created movie: #{m.title}"

m = Movie.new
m.title = "A Star is Born"
m.year = 2013
m.director = "Cooper"
m.actors << "Cooper"
m.actors << "Gaga"
m.length = 135
m.pic_url = "https://imagens.publicocdn.com/imagens.aspx/1277815?tp=UH&db=IMAGENS&type=PNG&w=823"
m.save

puts "Created movie: #{m.title}"

m = Movie.new









