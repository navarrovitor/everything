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

  def battlepage
    repeat_probability = 0.4

    @battle = Battle.new
    authorize @battle

    @user = current_user

    movies_seen = Movie.all.select { |movie| @user.movies.include?(movie) }
    movies_not_seen = Movie.all.select { |movie| !@user.movies.include?(movie) }

    # movies_seen_relevance = 0
    # movies_seen.each do |movie|
    #   movies_seen_relevance += movie.relevance
    # end

    # movies_seen_stops = [0]
    # movies_seen.each do |movie|
    #   movies_seen_stops << movie.relevance.to_f / movies_seen_relevance
    # end

    # movies_not_seen_relevance = 0
    # movies_not_seen.each do |movie|
    #   movies_not_seen_relevance += movie.relevance
    # end

    # movies_not_seen_stops = [0]
    # movies_not_seen.each do |movie|
    #   movies_not_seen_stops << movie.relevance.to_f / movies_not_seen_relevance
    # end

    @movie1 = []
    @movie2 = []
    invalid_movies = []

    @user.not_seen.each do |movie|
      invalid_movies << Movie.find(movie)
    end

    10.times do
      if movies_not_seen.length > 2
        roll = rand

        if roll > 1 - repeat_probability
          movie = movies_seen.sample
          while invalid_movies.include?(movie)
            movie = movies_seen.sample
          end
          @movie1 << movie if movie.present?
        else
          movie = movies_not_seen.sample
          while invalid_movies.include?(movie)
            movie = movies_not_seen.sample
          end
          @movie1 << movie if movie.present?
        end

        if roll > 1 - repeat_probability
          movie = movies_seen.sample
          while invalid_movies.include?(movie)
            movie = movies_seen.sample
          end
          @movie2 << movie if movie.present?
        else
          movie = movies_not_seen.sample
          while invalid_movies.include?(movie)
            movie = movies_not_seen.sample
          end
          @movie2 << movie if movie.present?
        end

      else

        movie = movies_not_seen.sample
        @movie1 << movie if movie.present?

        movie = movies_not_seen.sample
        @movie2 << movie if movie.present?

      end

      invalid_movies << @movie1
      invalid_movies << @movie2
    end
  end
end
