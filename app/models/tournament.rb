class Tournament < ApplicationRecord
  belongs_to :season, optional: true
  validates :tournament_name, presence: true, uniqueness: { scope: :season, message: "Statement already exists" }
end
