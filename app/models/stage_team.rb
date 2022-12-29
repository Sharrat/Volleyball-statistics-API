class StageTeam < ApplicationRecord
  belongs_to :team
  validates :team, presence: true
  belongs_to :tournament_stage
  validates :tournament_stage, presence: true#, uniqueness: { scope: :team, message: "Statement already exists" }
end
