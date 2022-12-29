class TournamentTeam < ApplicationRecord
  belongs_to :team
  validates :team, presence: true
  belongs_to :tournament
  validates :tournament, presence: true#, uniqueness: { scope: :team, message: "Statement already exists" }
end
