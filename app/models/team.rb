class Team < ApplicationRecord
  validates :Team_name, presence: true
  validates :Shortened_team_name, presence: true
end