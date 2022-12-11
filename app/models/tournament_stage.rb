class TournamentStage < ApplicationRecord
  belongs_to :tournament
  validates :tournament, presence: true
  validates :stage_name, presence: true, uniqueness: { scope: :tournament, message: "Statement already exists" }
end
