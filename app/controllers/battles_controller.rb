class BattlesController < ApplicationController
  def apitest
    @battle = Battle.new
    authorize @battle

    @keyword = params[:movie]
  end

  def landing
    @battle = Battle.new
    authorize @battle
  end

  def showmovies
    @battle = Battle.new
    authorize @battle

    @user = current_user
    @points = @user.points.order('points DESC')
  end

  def recommendations
    @battle = Battle.new
    authorize @battle

    # Define constants which will be used on this function
    # Get top 10% users to compare relevance and get suggestions
    top_users_quantity_pct = 0.1
    # If top 10% are less than 3, use 3
    top_users_quantity_min = 3
    # Get top 10% movies in the recommenders lists to make suggestions
    top_movies_quantity_pct = 0.1
    # But use at least 3
    top_movies_quantity_min = 3
    # Movies on top of the lists get more points
    pts_top_movies = 5
    qt_top_movies = 3
    # Movies high on the list get some points
    pts_mid_movies = 3
    qt_mid_movies = 7
    # Movies low on the list get no points
    pts_other_movies = 0

    # Initialize the user and other users, but pick only if number of movies rated by those users is higher than a minimum
    user = current_user
    other_users = User.all.reject { |user| user == current_user || user.points.length < top_movies_quantity_min}

    # If basic conditions are not met, go back to main screen
    if user.points.length < 3 || other_users.length < top_users_quantity_min
      redirect_to root_path
    else

      # Build other users relevance compared to current user
      relevances = {}

      t1 = []
      user.points.order('points DESC').each do |point|
        t1 << point.movie.title
      end

      other_users.each do |otheruser|
        t2 = []
        otheruser.points.order('points DESC').each do |point|
          t2 << point.movie.title
        end

        relevances[otheruser.id.to_s] = relevance(t1, t2).round(2)
      end

      # --> Pick top users from database
      # Get how many users are on database
      user_base_size = other_users.length
      # Get how many users will be used for the top comparison as a percentage of the whole, but has a minimum value
      top_users_size = (user_base_size * top_users_quantity_pct > top_users_quantity_min ? (user_base_size * top_users_quantity_pct).floor : top_users_quantity_min)
      # Pick the top X users in terms of relevance based on how many users will be used
      top_users = relevances.sort_by { |k,v| -v }[0..top_users_size - 1]
      # Save this in a hash because it will be needed later on
      relevances_hash = relevances
      # Transform the user from ids to instances of class user
      top_users = top_users.map { |user| User.find(user[0])}

      # --> Pick the top movies from relevant users which the current user has not rated
      # Create an empty array of movies that will be populated
      suggestions = []
      # Get all top X movies from the sorted user movie lists and populate the array of possible recommendations
      # Iterate through each user, sort its movies by points, get the top 5 and push into suggetions array
      top_users.each do |user|
        top_user_movies_list = user.points.order('points DESC')

        # Get the top movies using the same logic we used to get the top relevant users
        list_size = top_user_movies_list.length
        top_movies_number = (list_size * top_movies_quantity_pct > top_movies_quantity_min ? (list_size * top_movies_quantity_pct).floor : top_movies_quantity_min)
        top_movies = top_user_movies_list[0..top_movies_number - 1]

        # Transform these instances of points into the movies they point to
        top_movies.each do |point|
          suggestions << point.movie
        end
      end

      # Remove repeated movies
      suggestions = suggestions.uniq

      # Remove the movies that the current user has already rated
      user_list = user.points
      user_list.each do |point|
        suggestions.delete(point.movie)
      end

      # --> Build the suggestion list by order of relevance
      # Build a hash with keys = titles of suggested movies
      suggestions_ordered = {}
      suggestions.each do |sugg|
        suggestions_ordered[sugg.title.to_s] = 0
      end
      # The value of each hash pair is the relevance of that movie
      # The relevance will be given by relevance points
      # Relevance points are proportional to the position of given movie on each recommender list and the recommender relevance
      suggestions_ordered.each do |k,v|
        # Initialize: get the movie related to each suggestion
        movie = Movie.find_by(title: k.to_s)
        # Initialize arrays that will be used in the calculation
        points_for_positions = []
        points_for_user_relevance = []

        top_users.each do |user|
          # Get the user movie list in order of preference
          top_user_movies_list = user.points.order('points DESC')
          # Get the position of the suggestion movie in the user list
          movie_position = top_user_movies_list.index(Point.find_by(user_id: user.id, movie_id: movie.id))

          # Give points to each movie
          # Points for the position on each recommenders list
          if !movie_position.nil?
            if movie_position + 1 <= qt_top_movies
              points_for_positions << pts_top_movies
            elsif movie_position + 1 > qt_top_movies && movie_position + 1 < qt_mid_movies
              points_for_positions << pts_mid_movies
            else
              points_for_positions << pts_other_movies
            end
          else
            points_for_positions << 0
          end

          # Rescue the relevance value for this user on relevances_hash
          points_for_user_relevance << relevances_hash[user.id.to_s].to_f
        end

        # Compute the movie relevance as the weighted average of points for position and recommender relevance using function on appcontroller
        suggestions_ordered[k] = weightedaverage(points_for_positions, points_for_user_relevance)
      end

      # Order the hash by relevance
      suggestions_ordered = suggestions_ordered.sort_by { |_, v| -v }

      # --> Send to view: array of movies suggested in order of relevance
      @recommendations = []
      suggestions_ordered.each do |k, _|
        @recommendations << Movie.find_by(title: k.to_s)
      end
    end
  end

  def battlepage
    @battle = Battle.new
    authorize @battle

    @user = current_user
    @number_of_ratings = ratings_count(@user).nil? ? 0 : ratings_count(@user)
    @user_level = user_level(@number_of_ratings)

    movies_seen = Movie.all.select { |movie| @user.movies.include?(movie) && !@user.not_seen.include?(movie.id) }
    movies_not_seen = Movie.all.select { |movie| !@user.movies.include?(movie) && !@user.not_seen.include?(movie.id) }
    repeat_probability = (movies_seen.length.to_f / Movie.all.length)

    @movie1 = []
    @movie2 = []

    10.times do
      if movies_seen.length > 2
        roll = rand

        if roll < repeat_probability
          movie = movies_seen.sample
          @movie1 << movie if movie.present? && !@movie1.include?(movie) && !@movie2.include?(movie)
        else
          movie = movies_not_seen.sample
          @movie1 << movie if movie.present? && !@movie1.include?(movie) && !@movie2.include?(movie)
        end

        if roll < repeat_probability
          movie = movies_seen.sample
          @movie2 << movie if movie.present? && !@movie1.include?(movie) && !@movie2.include?(movie)
        else
          movie = movies_not_seen.sample
          @movie2 << movie if movie.present? && !@movie1.include?(movie) && !@movie2.include?(movie)
        end
      else

        movie = movies_not_seen.sample
        @movie1 << movie if movie.present? && !@movie1.include?(movie) && !@movie2.include?(movie)

        movie = movies_not_seen.sample
        @movie2 << movie if movie.present? && !@movie1.include?(movie) && !@movie2.include?(movie)

      end
    end
  end
end
