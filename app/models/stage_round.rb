class StageRound < ApplicationRecord
  belongs_to :tournament_stage
  validates :tournament_stage, presence: true
  validates :round_name, presence: true, uniqueness: { scope: :tournament_stage, message: "Statement already exists" }
  has_many :matches, foreign_key: 'round', dependent: :restrict_with_error
end
