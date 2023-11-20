class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :room # dependent: :destroy removed recentely
end
