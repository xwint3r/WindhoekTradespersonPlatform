class Service < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :location
  has_many :reviews, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :price
  validates_presence_of :location_id
  validates_presence_of :category_id


  validate :validate_image


  geocoded_by :full_address
  after_validation :geocode

  mount_uploaders :service_pictures, ServicePictureUploader # Use CarrierWave uploader for the image
  serialize :service_pictures, JSON # Ensure that you're using JSON if the database doesn't natively support array types

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "city", "country", "created_at", "description", "id", "latitude", "location", "location_id", "longitude", "name", "price", "region", "service_pictures", "street_address", "updated_at", "user_id"]
  end

  def full_address
    [street_address, location&.name, city, region, country].compact.join(', ')
  end
  
  
  def self.search(params)
    services = Service.all
  
    services = services.where(category_id: params[:category]) if params[:category].present?
    services = services.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
  
    windhoek_location = "Windhoek, Namibia"
    if params[:location].present?
      location_name = "#{params[:location]}, #{windhoek_location}"
      result = Geocoder.search(location_name).first
  
      if result
        latitude = result.latitude
        longitude = result.longitude
        services = Service.near([latitude, longitude], 2, units: :km) if latitude && longitude
      end
    end
  
    services
  end


  def self.searchlocation(params)
    services = Service.all
  
    #services = services.where(category_id: params[:category]) if params[:category].present?
    #services = services.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
  
    windhoek_location = "Windhoek, Namibia"
    if params[:location].present?
      location_name = "#{params[:location]}, #{windhoek_location}"
      result = Geocoder.search(location_name).first
  
      if result
        latitude = result.latitude
        longitude = result.longitude
        services = Service.near([latitude, longitude], 1, units: :km) if latitude && longitude
      end
    end
  
    services
  end

  def self.searchcategory(params)
    services = Service.all
  
    services = services.where(category_id: params[:category]) if params[:category].present?
     
    services
  end

  private

  def validate_image
    if service_pictures.present?
      service_pictures.each do |uploader|
        uploader.file.extension.in?(%w(jpg jpeg gif png))
        errors.add(:service_pictures, "must be a valid image format (jpg, jpeg, gif, png)") unless uploader.file.extension.in?(%w(jpg jpeg gif png))
      end
    end
  end
  

  #def validate_image
    #if service_pictures.present? && !image?(service_pictures.file.content_type)
      #errors.add(:service_pictures, "must be a valid image format (jpg, jpeg, gif, png)")
    #end
  #end
  
  #def image?(content_type)
    #content_type.start_with?('image/')
  #end
end
