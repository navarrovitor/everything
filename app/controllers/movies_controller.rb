class MoviesController < ApplicationController
  def index
    @movies = policy_scope(Movie)
  end

  def show
    authorize @movie
    @movie = Movie.find(params[:id])

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
