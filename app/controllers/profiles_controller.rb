class ProfilesController < ApplicationController
  def new
    @profile = Profile.new(user: current_user)
    authorize @profile
  end

  def index
    @profiles = policy_scope(Profile)

    user = current_user
    @other_users = User.all.reject { |user| user == current_user}

    @relevances = []

    t1 = []
    user.points.order('points DESC').each do |point|
      t1 << point.movie.title
    end

    @other_users.each do |otheruser|
      t2 = []
      otheruser.points.order('points DESC').each do |point|
        t2 << point.movie.title
      end

      @relevances << relevance(t1, t2).round(2)
    end

  end

  def create
    @profile = Profile.new(params[profile_params])
    @profile.user = current_user
    profile.save
    redirect_to profile_path(profile)
    authorize @profile
  end

  def show
    @profile = Profile.find(params[:id])
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
    @profile.user.destroy
    redirect_to root_path
    authorize @profile
  end

  private

  def profile_params
  params.require(:profile).permit(:username, :photo, :user_id)
  end
end
