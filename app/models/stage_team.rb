class StageTeam < ApplicationRecord
  belongs_to :team
  belongs_to :tournament_stage
end
