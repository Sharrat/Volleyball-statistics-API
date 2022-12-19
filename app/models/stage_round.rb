class StageRound < ApplicationRecord
  belongs_to :tournament_stage
  validates :round_name, presence: true, uniqueness: { scope: :tournament_stage, message: "Statement already exists" }
  #has_many :matches
end
