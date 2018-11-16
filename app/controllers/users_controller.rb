class UsersController < ApplicationController
  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find(userparams[:id])
    authorize @user
  end

  private

  def userparams
    params.require(:user).permit(:id)
  end
end
