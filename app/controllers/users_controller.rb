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
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    @points = Point.where("user_id = ?", @user.id).order("points DESC")
    @number_of_ratings = ratings_count(@user).nil? ? 0 : ratings_count(@user)
    @user_level = user_level(@number_of_ratings)
    authorize @user
  end

  private

  def ratings_count(user)
    # gets the amount of movies rated by a user
    count = Point.all.select{ |point| point.user_id == user.id}.count
    return count
  end

  def user_level(ratings)
    # stablishes a "level" according to the number of ratings by a user
    # returns rank, a custom message and the next user ranking
    message1 = "You've rated #{ratings} movies."
    rank = "Noobie"
    next_rank = "Beginner (#{3 - ratings} more movie#{ratings < 2 ? 's' : ''})"
    case ratings
    when 0
      message1 = "You haven't rated any movies yet. :/"
      message2 = "Rate 3 movies to get your first recommendations."
    when 1..2
      message2 = "Rate #{3 - ratings} more movie#{ratings < 2 ? 's' : ''} to get your first recommendations."
    when 3..9
      rank = "Beginner"
      next_rank = "Film Student (#{10 - ratings} more movie#{ratings < 9 ? 's' : ''})"
      message2 = "Well done! Rate more movies to get better recommendations."
    when 10..49
      rank = "Film Student"
      next_rank = "Cinephile (#{50 - ratings} more movie#{ratings < 49 ? 's' : ''})"
      message2 = "Keep going to get even better recommendations!"
    else
      rank = "Cinephile"
      message2 = "Wow! You're on the right track. Keep rating!"
      next_rank = "None. You're a top user."
    end
    return [rank, next_rank, message1, message2]
  end

  def userparams
    params.require(:user).permit(:id)
  end
end
