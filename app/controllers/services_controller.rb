class ServicesController < ApplicationController

    before_action :authenticate_user!, only: [:create, :new] # This ensures the user is logged in
    before_action :is_service_user, only: [:edit, :update] # this ensures only the service user can edit and update
    before_action :is_businessperson, only: [:create, :edit, :update] # this ensures only a bsuiness person can create edit and update a service
    before_action :is_businessperson_new_service, only: [:new] # This ensure only the owner of the profile can add a new service to their profile

    def index

      #when online vvvvv
      # visitor_latitude = request.location.latitude
      # visitor_longitude = request.location.longitude

    
      visitor_latitude = -22.5784636
      visitor_longitude = 17.0264791

      # Find services near the visitor's location, sorted by distance and then by highest average rating
      @services = Service.near([visitor_latitude, visitor_longitude])
                        .includes(:location, :reviews)
                        .sort_by { |service| [-service.reviews.average(:rating).to_f, service.distance] }
                        .first(5)

    end

    def new
      @service = current_user.services.build
    end

    def show
      @service = Service.find(params[:id]) # Find the service by its ID
      
      @reviews = Review.where(service_id: @service) # find the service id that correspond with the reviews

      if @reviews.blank?
        @avg_rating = 0 
      else
        @avg_rating = @reviews.average(:rating).round(0)
      end

    end

    def search
      @services = Service.includes(:location, :reviews).search(params)
    end

    def search_by_location
      @services = Service.includes(:location, :reviews).searchlocation(params)
    end

    def search_by_category
      @services = Service.includes(:location, :reviews).where(category_id: params[:category])
    end

    def create
      @service = current_user.services.build(service_params)
  
      # Get the latitude and longitude of the provided address
      location = Geocoder.search(@service.location_id).first
      service_coordinates = [location.latitude, location.longitude] if location.present?
  
      # Restrict the service creation to a specific area (Windhoek, Namibia)
      windhoek_center = [-22.5598, 17.0832] # Coordinates for the center of Windhoek
  
      # Calculate the distance between the service coordinates and Windhoek center
      distance_to_windhoek = Geocoder::Calculations.distance_between(service_coordinates, windhoek_center)

      maximum_allowed_distance = 10
  
      if distance_to_windhoek > maximum_allowed_distance
        flash[:error] = "Please select a location within Windhoek, Namibia."
        render :new
      elsif @service.save
        redirect_to @service, notice: "Service was successfully created."
      else
        flash[:danger] = @service.errors.full_messages.to_sentence
        render :new
      end
    end

    def edit
      @service = Service.find(params[:id])
      # Check if the current user is authorized to edit the service
      unless current_user == @service.user
        redirect_to root_path, alert: "You are not authorized to edit this service."
      end
    end

    def update
      @service = Service.find(params[:id])
      # Ensure the current user is authorized to update the service
      unless current_user == @service.user
        redirect_to root_path, alert: "You are not authorized to update this service."
        return
      end
    
      service_location = Geocoder.search(@service.location_id).first
      service_coordinates = [service_location.latitude, service_location.longitude] if service_location.present?
    
      windhoek_center = [-22.5598, 17.0832] # Coordinates for the center of Windhoek
    
      distance_to_windhoek = Geocoder::Calculations.distance_between(service_coordinates, windhoek_center)

      maximum_allowed_distance = 10
    
      if distance_to_windhoek > maximum_allowed_distance
        flash[:error] = "Please select a location within Windhoek, Namibia."
        render :edit
      elsif @service.update(service_params)
        redirect_to @service, notice: "Service was successfully updated."
      else
        flash[:danger] = @service.errors.full_messages.to_sentence
        render :edit
      end
    end
    
  
    private  
    def service_params
      params.require(:service).permit(:name, :description, :price, :location_id, :category_id, {service_pictures: [], service_pictures_cache: [] })
      #encapsulate and whitelist the parameters that are accepted when creating or updating a service
    end    

    def is_service_user
      # checks if this is the user of the service 
      @service = Service.find(params[:id])
  
      unless current_user == @service.user
        redirect_to root_path, alert: "You are not authorized to access this service."
      end
    end

    def is_businessperson
       
      if !current_user.businessperson?
        redirect_to root_path, alert: "You are not authorized to access this service. 1"
      end
    end

    def is_businessperson_new_service
      if !current_user.businessperson?
        redirect_to root_path, alert: "You are not authorized to access this service."
      end
    end
    
  
  end
  