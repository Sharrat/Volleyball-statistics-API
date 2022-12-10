class TournamentStage < ApplicationRecord
  belongs_to :tournament, optional: false
  validates :stage_name, presence: true, uniqueness: { scope: :tournament, message: "Statement already exists" }
end
