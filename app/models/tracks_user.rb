class TracksUser < ApplicationRecord
  belongs_to :track
  belongs_to :user
  belongs_to :event, required: false
  # validates :source, in: ["spotify", "favourites"]
end
