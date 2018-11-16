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
    @battle = Battle.new
    authorize @battle

    @user = current_user

    movies_seen = Movie.all.select { |movie| @user.movies.include?(movie) && !@user.not_seen.include?(movie.id) }
    movies_not_seen = Movie.all.select { |movie| !@user.movies.include?(movie) && !@user.not_seen.include?(movie.id) }
    repeat_probability = (movies_seen.length.to_f / Movie.all.length)


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
