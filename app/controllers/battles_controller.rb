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

    movies_seen = Movie.all.select { |movie| @user.movies.include?(movie) }
    movies_not_seen = Movie.all.select { |movie| !@user.movies.include?(movie) }

    @movie1 = []
    @movie2 = []

    10.times do
      if movies_not_seen.length > 2
        roll = rand

        if roll > 0.85
          @movie1 << movies_seen.sample
        else
          @movie1 << movies_not_seen.sample
        end
        if roll > 0.85
          @movie2 << movies_seen.sample
        else
          @movie2 << movies_not_seen.sample
        end
      end
    end
  end
end
