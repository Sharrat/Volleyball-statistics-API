class Season < ApplicationRecord
  validates :Season_name, presence: true
  validates :Shortened_season_name, presence: true
end
