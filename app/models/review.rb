class Review < ApplicationRecord
    belongs_to :user, dependent: :destroy
    belongs_to :service, dependent: :destroy

    # only have one review UNCOMMENT LATER
    #validates :service_id, uniqueness: { scope: :user_id, message: "You have already reviewed this service" }
  end
  