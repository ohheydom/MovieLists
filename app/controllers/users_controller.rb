class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :redirect_if_invalid_username

  def show
    if params[:id] == current_user.username
      @profile = ProfilePage.new(current_user)
    else
      @profile = ProfilePage.new(user, current_user)
    end
  end

  def user
    User.find(params[:id])
  end

  private

  def redirect_if_invalid_username
    redirect_to profile_path(current_user) if User.where(username: params[:id]).blank?
  end
end
