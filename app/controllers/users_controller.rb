class UsersController < ApplicationController
  def index
    @users = policy_scope(User)
    # @users = User.all
    # authorize @user
    user = current_user

    if user.points.length < 3
      redirect_to root_path

    else

      @other_users = User.all.reject { |user| user == current_user || user.points.length < 3}

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

      max_relevance = @relevances.max
      @relevances.map! { |val| ((val.to_f / max_relevance) * 100).round(1) }
    end
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
