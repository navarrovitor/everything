class ThingsController < ApplicationController
  def index
    @things = policy_scope(Thing).order('battles_won DESC')
  end

  def show
    @things = Movie.find(params[:id])
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
