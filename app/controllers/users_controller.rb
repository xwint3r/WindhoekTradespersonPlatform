class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

    def show
      @user = current_user
      redirect_to user_profile_path(current_user.username)
    end

    def show_by_username
      @user = User.find_by(username: params[:username])
      if @user.nil?
        # Handle this condition (for example, redirect to an error page or render an error message)
        # For example, you can redirect to the root path or render an error page
        redirect_to root_path, alert: "User not found"
      end
    end
end