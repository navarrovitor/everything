class MoviesController < ApplicationController
  def index
<<<<<<< HEAD
    @movies = policy_scope(Movie).order('battles_won DESC')
=======
    @movies = policy_scope(Movie).order("title")
>>>>>>> a023bf292fe9be02715973dbd275f435e1ec8c4a
  end

  def show
    @movie = Movie.find(params[:id])
    authorize @movie
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
