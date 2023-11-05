class Review < ApplicationRecord
    belongs_to :user
    belongs_to :service

    # only have one review UNCOMMENT LATER
    #validates :service_id, uniqueness: { scope: :user_id, message: "You have already reviewed this service" }
  end
  