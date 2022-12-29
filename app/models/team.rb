class Team < ApplicationRecord
  validates :Team_name, presence: true
  validates :Shortened_team_name, presence: true
  has_many :players, dependent: :restrict_with_error
  has_many :stage_teams, dependent: :restrict_with_error
  has_many :tournament_teams, dependent: :restrict_with_error  
end
