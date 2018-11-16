Point.all.each do |point|
  point.destroy
end

Movie.all.each do |movie|
  movie.destroy
end

`rails db:seed:top100`
