class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    include Pagy::Backend
    before_action :turbo_frame_request_variant


    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :firstname, :lastname]) # Permit username during sign up
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :firstname, :lastname]) # Permit username during profile update
    end


    private

    # creating a unique name for the conversation consisting of the two users ids 
    # ensuring the order is maintained
    def get_name(user1, user2)
      user = [user1, user2].sort
      "private_#{user[0].id}_#{user[1].id}"
    end

    def turbo_frame_request_variant
      request.variant = :turbo_frame if turbo_frame_request?
    end


end
