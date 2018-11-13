class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
    authorize @profile
  end

  def create
    @profile = Profile.new(params [profile_params])
    profile.save
    redirect_to profile_path(profile)
    authorize @profile
  end

  def show
    @profile = Profile.find (params[:id] )
    authorize @profile
  end

  def edit
    @profile = Profile.find(params[:id])
    authorize @profile
  end

  def update
    @profile = Profile.find(params[:id])
    profile.update(profile_params)
    redirect_to profile_path(@profile)
    authorize @profile
  end

  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
    redirect_to root_path
    authorize @profile
  end

  private

  def profile_params
  params.require(:profile).permit(:username, :photo)
  end
end