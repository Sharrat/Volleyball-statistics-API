class Tournament < ApplicationRecord
  belongs_to :season, optional: true
  validates :tournament_name, presence: true, uniqueness: { scope: :season, message: "Statement already exists" }
  has_many :tournament_stages, dependent: :restrict_with_error
  has_many :tournament_teams, dependent: :restrict_with_error 
end
