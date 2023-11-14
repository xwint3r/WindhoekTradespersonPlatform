class Room < ApplicationRecord
    should validate_uniqueness_of(:name)
    scope :public_rooms, ->{ where(is_private: false) }
end
