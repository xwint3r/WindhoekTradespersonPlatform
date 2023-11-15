class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

    def show
      @user = current_user
      redirect_to user_profile_path(current_user.username)
    end

    def show_chat
    end

    def show_by_username
      @user = User.find_by(username: params[:username])
      @avg_rating_total = @user.average_rating
      @num_of_reviews = @user.total_num_ratings

      # @avg_rating_total = @user.reviews.any? ? @user.reviews.average(:rating).to_f.round(2) : 0

      if @user.nil?
        # Handle this condition (for example, redirect to an error page or render an error message)
        # For example, you can redirect to the root path or render an error page
        redirect_to root_path, alert: "User not found"
      end
    end
end