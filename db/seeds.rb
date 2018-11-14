# Movie Example: Back to the Future

p = Point.new
p.thing = Thing.all.select { |thing| thing.category == 'Movie' }.sample
p.points = 5
p.user_id = 1
p.save

p = Point.new
p.thing = Thing.all.select { |thing| thing.category == 'Movie' }.sample
p.points = 5
p.user_id = 1
p.save

p = Point.new
p.thing = Thing.all.select { |thing| thing.category == 'Movie' }.sample
p.points = 5
p.user_id = 1
p.save

p "Points generated"
