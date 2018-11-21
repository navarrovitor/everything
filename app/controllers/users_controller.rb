class UsersController < ApplicationController
  def index
    @users = policy_scope(User)
    # @users = User.all
    # authorize @user
  end

  def show
    @points = Point.where("user_id = ?", params[:id])
    @user = User.find(params[:id])
    authorize @user
  end

  private

  def userparams
    params.require(:user).permit(:id)
  end
end
