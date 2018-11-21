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
    @number_of_ratings = ratings_count(@user)
    @user_level = user_level(@number_of_ratings)
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
      next_rank = "Beginner (#{10 - ratings} more movie#{ratings < 9 ? 's' : ''})"
      message2 = "Well done! Rate more movies to get better recommendations."
    when 10..49
      rank = "Film student"
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
