class MoviesController < ApplicationController
  def index
    @movies = policy_scope(Movie).order('battles_won DESC')

    @movies_winrate = []
    @movies_awareness = []

    @movies.each do |movie|
      totalbattles = movie.battles_total
      winpercent = ((movie.battles_won.to_f / totalbattles) * 100).round(1)
      winpercent = "-" if winpercent.nan?
      @movies_winrate << winpercent

      users_seen = Point.all.select { |point| point.movie == movie }.length
      users_not_seen = User.all.select { |user| user.not_seen.include?(movie.id) }.length
      awareness = ((users_seen.to_f / (users_seen + users_not_seen)) * 100).round(1)
      awareness = "-" if awareness.nan?
      @movies_awareness << awareness
    end
  end

  def show
    @movie = Movie.find(params[:id])
    authorize @movie

    @totalbattles = @movie.battles_total
    @winpercent = ((@movie.battles_won.to_f / @totalbattles) * 100).round(1)

    users_seen = Point.all.select { |point| point.movie == @movie }.length
    users_not_seen = User.all.select { |user| user.not_seen.include?(@movie.id) }.length
    @awareness = ((users_seen.to_f / (users_seen + users_not_seen)) * 100).round(1)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
