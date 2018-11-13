class PointsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    user = User.find(params[:user_id])

    battle = Battle.new
    authorize battle

    if params[:vote_result].to_i == 1
      moviewinner = params[:movie1_id]
      movieloser = params[:movie2_id]
    else
      moviewinner = params[:movie2_id]
      movieloser = params[:movie1_id]
    end

    moviewinner = Movie.find(moviewinner)
    movieloser = Movie.find(movieloser)

    moviewinnerseen = user.movies.include?(moviewinner)
    movieloserseen = user.movies.include?(movieloser)

    if moviewinnerseen
      winner_point = user.points.select { |point| point.movie == moviewinner }[0]
    else
      winner_point = Point.new
      winner_point.user_id = user.id
      winner_point.movie_id = moviewinner.id
      winner_point.save
    end

    if movieloserseen
      loser_point = user.points.select { |point| point.movie == movieloser }[0]
    else
      loser_point = Point.new
      loser_point.user_id = user.id
      loser_point.movie_id = movieloser.id
      loser_point.save
    end

    if winner_point.points >= loser_point.points
      winner_point.points += 1
      winner_point.save
    else
      winner_point.points = loser_point.points + 1
      winner_point.save
    end

    redirect_to battlepage_path
  end

  def destroy
  end
end
