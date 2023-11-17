class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

    def show
      @user = current_user
      redirect_to user_profile_path(current_user.username)
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

    # showing a conversation/chat between two users
    def show_chat
      @user = User.find(params[:id])
      @users = User.all_except(current_user)
  
      @room = Room.new
      @rooms = Room.public_rooms
      @room_name = get_name(@user, current_user)
      @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, current_user], @room_name)
  
      @message = Message.new
      
      pagy_messages = @single_room.messages.order(created_at: :desc)
      @pagy, messages = pagy(pagy_messages, items: 10)
      @messages = messages.reverse
      
      render 'rooms/index'
    end

    private

    # creating a unique name for the conversation consisting of the two users ids 
    # ensuring the order is maintained
    def get_name(user1, user2)
      user = [user1, user2].sort
      "private_#{user[0].id}_#{user[1].id}"
    end
end