class Match < ApplicationRecord
  belongs_to :round, class_name: "StageRound"
  validates :round, presence: true

  belongs_to :team1, class_name: "Team"
  validates :team1, presence: true

  belongs_to :team2, class_name: "Team"
  validates :team2, presence: true

  validates :match_name, presence: true, uniqueness: { scope: :match_date, message: "Statement already exists (record with the same name and date already exists)" }
  # delete later! validates :match_date, presence: true, uniqueness: { scope: :stage_round, message: "Statement already exists" }
  validates :result, presence: true
end
