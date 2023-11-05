class ReviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_service, only: [:new, :create]
  
    def new
      @review = Review.new
    end
  
    def create
      @review = current_user.reviews.build(review_params) # setting the user id to the current user
      @review.service = @service # setting the service id to the current service
      if @review.save
        redirect_to @service
      else
        render :new
      end
    end
  
    def show
    end
  
    private
  
    def review_params
      params.require(:review).permit(:content, :rating) # the parameters that will be passed to be saved
    end
  
    def set_service
      @service = Service.find(params[:service_id]) # finding the service id of the service to set it later
    end
  end
  