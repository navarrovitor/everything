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

    top_users_quantity_pct = 0.1
    top_users_quantity_min = 5
    top_movies_quantity_pct = 0.1
    top_movies_quantity_min = 5

    user = current_user

    if user.points.length < 3
      redirect_to root_path

    else

      other_users = User.all.reject { |user| user == current_user || user.points.length < 3}

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

      max_relevance = relevances.max_by { |k,v| v}[1]
      relevances.each { |k,v| relevances[k] = ((relevances[k] / max_relevance) * 100).round(1) }

      # --> Pick top users from database
      # Get how many users are on database
      user_base_size = other_users.length
      # Get how many users will be used for the top comparison as a percentage of the whole, but has a minimum value
      top_users_size = (user_base_size * top_users_quantity_pct > top_users_quantity_min ? (user_base_size * top_users_quantity_pct).floor : top_users_quantity_min)
      # Pick the top X users in terms of relevance based on how many users will be used
      top_users = relevances.sort_by { |k,v| -v }[0..top_users_size - 1]
      relevances_hash = relevances
      # Transform the user from ids to instances of class user
      top_users = top_users.map { |user| User.find(user[0])}

      # --> Pick the top movies from relevant users which the current user has not rated
      # Create an empty array of movies that will be populated
      suggestions = []
      # Get all top X movies from the sorted user movie lists and populate the array of possible recommendations
      # Iterate through each user, sort its movies by points, get the top 5 and push into suggetions array
      top_users.each do |user|
        top_top_user_movies = []

        top_user_movies_list = user.points.order('points DESC')

        # Get the top movies using the same logic we used to get the top relevant users
        list_size = top_user_movies_list.length
        top_movies_number = (list_size * top_movies_quantity_pct > top_movies_quantity_min ? (list_size * top_movies_quantity_pct)/ floor : top_movies_quantity_min)
        top_movies = top_user_movies_list[0..top_movies_number - 1]

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
      # The value of each hash pair is the relevance of that movie
      suggestions.each do |sugg|
        suggestions_ordered[sugg.title.to_s] = 0
      end
      # The relevance will be given by relevance points
      # Relevance points are proportional to the position of given movie on each recommender list and the recommender relevance
      suggestions_ordered.each do |k,v|
        movie = Movie.find_by(title: k.to_s)
        points_for_positions = []
        points_for_user_relevance = []

        top_users.each do |user|
          top_user_movies_list = user.points.order('points DESC')
          movie_position = top_user_movies_list.index(Point.find_by(user_id: user.id, movie_id: movie.id))

          # Give points: 5 if top 3, 3 if up to 10, 0 if not top 10
          if !movie_position.nil?
            if movie_position + 1 <= 3
              points_for_positions << 5
            elsif movie_position + 1 > 3 && movie_position + 1 < 10
              points_for_positions << 3
            else
              points_for_positions << 0
            end
          else
            points_for_positions << 0
          end

          # Rescue the relevance value for this user on relevances_hash
          points_for_user_relevance << relevances_hash[user.id.to_s].to_f
        end


        # Compute the movie relevance as the weighted average of points for position and recommender relevance
        sum_product = 0
        sum_weights = 0
        (0..points_for_positions.length - 1).to_a.each do |counter|
          sum_product += points_for_positions[counter] * points_for_user_relevance[counter]
          sum_weights += points_for_user_relevance[counter]
        end
        suggestions_ordered[k] = sum_product / sum_weights

      end

      # Order the hash by relevance
      suggestions_ordered = suggestions_ordered.sort_by { |_, v| -v }
    end

    # --> Send to view: array with names of movies suggested in order of relevance
    @recommendations = []
    suggestions_ordered.each do |k, v|
      @recommendations << Movie.find_by(title: k.to_s)
    end
  end

  def battlepage
    @battle = Battle.new
    authorize @battle

    @user = current_user

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
