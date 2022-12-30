class TournamentStage < ApplicationRecord
  belongs_to :tournament
  validates :tournament, presence: true
  validates :stage_name, presence: true, uniqueness: { scope: :tournament, message: "Statement already exists" }
  has_many :stage_teams, dependent: :restrict_with_error
  has_many :stage_rounds, dependent: :restrict_with_error 
end
