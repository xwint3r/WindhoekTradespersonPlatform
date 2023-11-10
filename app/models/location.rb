class Location < ApplicationRecord
    has_many :services
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "name", "updated_at"]
      end
end
