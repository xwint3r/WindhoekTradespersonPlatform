class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

    # definine the relationships
    has_many :services, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_many :favorites, dependent: :destroy

    scope :all_except, ->(user) { where.not(id: user) }

    # roles that say what kind of user they are
    enum role: { customer: 0, businessperson: 1, admin: 2 }

    #validates that the username is unique
    validates :username, presence: true, uniqueness: true

    #makes sure the user inputs a phone number in an appropriate format 0XXXXXXXXX
    validates :phone_number, format: { with: /\A0\d{9}\z/, message: 'must start with 0 and be 10 digits' }, allow_blank: true

    # UNCOMMENT after you've seeded user in the schema with :profile picture
    #mount_uploader :profile_picture, ProfilePictureUploader # to upload profile picture

    
    def self.ransackable_attributes(auth_object = nil)
      ["created_at", "email", "encrypted_password", "firstname", "id", "lastname", "password_digest", "phone_number", "profession", "remember_created_at", "reset_password_sent_at", "reset_password_token", "role", "updated_at", "username"]
    end


    def average_rating
      services_with_reviews = services.includes(:reviews).where.not(reviews: { rating: nil })
      total_ratings = services_with_reviews.sum { |service| service.reviews.average(:rating).round(0) }
      
      if services_with_reviews.size.positive?
        total_ratings / services_with_reviews.size
      else
        0 # or any default value you prefer when there are no reviews available
      end
    end
    

    def total_num_ratings
      services_with_reviews = services.includes(:reviews).where.not(reviews: { rating: nil })
      services_with_reviews.size
    end


    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
      else
        find_by(conditions)
      end
    end
  

  end