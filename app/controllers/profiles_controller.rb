class ProfilesController < ApplicationController
  def new
    authorize @profile
  end

  def create
    authorize @profile
  end

  def show
    authorize @profile
  end

  def edit
    authorize @profile
  end

  def update
    authorize @profile
  end

  def destroy
    authorize @profile
  end
end
