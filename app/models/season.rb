class Season < ApplicationRecord
  validates :Season_name, presence: true, uniqueness: true
  validates :Shortened_season_name, presence: true, uniqueness: true
  has_many :Tournaments, dependent: :restrict_with_error
end
