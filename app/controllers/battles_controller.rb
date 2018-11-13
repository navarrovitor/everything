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
    @points = @user.points
  end

  def battlepage
    @battle = Battle.new
    authorize @battle

    @user = current_user

    movies_seen = Movie.all.select { |movie| @user.movies.include?(movie) }
    movies_not_seen = Movie.all.select { |movie| !@user.movies.include?(movie) }

    if movies_not_seen.length > 1
      roll = rand
      if roll > 0.5
        @movie1 = movies_seen.sample
        @movie1_seen = true
        movies_seen.delete(@movie1)
      else
        @movie1 = movies_not_seen.sample
        @movie1_seen = false
        movies_not_seen.delete(@movie1)
      end

      roll = rand
      if roll > 0.5
        @movie2 = movies_seen.sample
        @movie2_seen = true
        movies_seen.delete(@movie2)
      else
        @movie2 = movies_not_seen.sample
        @movie2_seen = false
        movies_not_seen.delete(@movie2)
      end
    else
      @movie1 = movies_seen.sample
      @movie1_seen = true
      movies_seen.delete(@movie1)
      @movie2 = movies_seen.sample
      @movie2_seen = true
      movies_seen.delete(@movie2)
    end
  end
end
