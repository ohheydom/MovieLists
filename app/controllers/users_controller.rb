class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :redirect_if_invalid_username

  def show
    if params[:id] == current_user.username
      @profile = ProfilePage.new(current_user, nil, by_year: params[:by_year])
    else
      @profile = ProfilePage.new(user, current_user, by_year: params[:by_year])
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
