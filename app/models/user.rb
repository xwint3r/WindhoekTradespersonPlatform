class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    # roles that say what kind of user they are
    enum role: { customer: 0, businessperson: 1, admin: 2 }

    validates :username, presence: true, uniqueness: true
    # Other Devise-related configurations and associations

    # definine the relationships
    has_many :services, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_many :favorites, dependent: :destroy

    # UNCOMMENT after you've seeded user in the schema with :profile picture
    #mount_uploader :profile_picture, ProfilePictureUploader # to upload profile picture

    def average_rating
      services_with_reviews = services.includes(:reviews).where.not(reviews: { rating: nil })
      total_ratings = services_with_reviews.sum { |service| service.reviews.average(:rating).round(0) }
      total_ratings / services_with_reviews.size
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