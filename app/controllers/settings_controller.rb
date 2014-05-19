class SettingsController < ApplicationController
  before_action :redirect_if_not_current_user

  def show
    @user = User.find(params[:user_id])
  end

  def save_movie_list

  end

  private

  def redirect_if_not_current_user
    redirect_to user_settings_path(current_user) unless params[:user_id] == current_user.username
  end
end
