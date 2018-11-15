class RegistrationsController < Devise::RegistrationsController

  def update
    current_user.update(user_params)
    redirect_to root_path
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private

  def user_params
    params.require(:user).permit(:email, :photo)
  end
end
