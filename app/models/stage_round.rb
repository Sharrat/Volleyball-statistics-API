class StageRound < ApplicationRecord
  validates :round_name, presence: true
  belongs_to :tournament_stage
  #has_many :matches
end
