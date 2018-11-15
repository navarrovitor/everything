x = ['T', 'R']

y = ['T', 'V']

z = ['T', 'R', 'V']

a = ['R', 'T', 'W', 'V', 'U']

b = ['W', 'V', 'S', 'U']

c = ['S', 'U', 'W', 'T', 'V']

d = ['W', 'R', 'S', 'T', 'U', 'V']

e = ['T', 'R', 'S', 'V', 'U']

all_ratings = [x, y, z, a, b, c, d, e]

def relative_position(item, array)
  # returns a value between 1 and -1
  # 1 for first item, 0 for last item
  # equal distances between items
  if array.size <= 1
    return 0
  elsif array.size.odd?
    median = array.size / 2
    increment = 1.0 / median
    value = (array.index(item) - median) * (- increment)
    value
  else
    increment = 2.0 / (array.size - 1)
    value = 1 - (array.index(item) * increment)
  end
end

def relative_diff(item, array1, array2)
  # calculates the difference of index between item in two arrays
  # if item not in one array, gives the index in the other
  # if item not in any array, returns 0
  if array1.include?(item) && array2.include?(item)
    return (relative_position(item, array1) - relative_position(item, array2)).abs
  elsif array1.include?(item)
    return relative_position(item, array1)
  elsif array2.include?(item)
    return relative_position(item, array2)
  else
    return nil
  end
end

def euclidean_distance(array1, array2)
  # gives the vector distance of two arrays
  # item is axis, index is value
  if array1 & array2 == []
    return nil
  else
    all_distances = []
    array1.each do |item|
      # calculates distance for all items in array 1
      distance = relative_diff(item, array1, array2)
      all_distances << distance
    end
    (array2 - array1).each do |item|
      distance = relative_diff(item, array1, array2)
      all_distances << distance
    end
    sum_of_squared_distances = 0
    all_distances.each do |distance|
      sum_of_squared_distances += distance**2
    end
    return Math.sqrt(sum_of_squared_distances)
  end
end

def relevance(array1, array2)
  distance = euclidean_distance(array1, array2)
  intersection_size = (array1 & array2).size
  relevance = distance / intersection_size
  return relevance
end
