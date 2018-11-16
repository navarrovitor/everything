Point.all.each do |point|
  point.destroy
end

User.all.each do |user|
  user.destroy
end

Profile.all.each do |user|
  user.destroy
end

Movie.all.each do |movie|
  movie.destroy
end

p "Hard reset Concluded"
