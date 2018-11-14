class MoviesController < ApplicationController
  def index
    @movies = policy_scope(Movie).order('battles_won DESC')
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
