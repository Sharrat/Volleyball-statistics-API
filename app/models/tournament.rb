class Tournament < ApplicationRecord
  belongs_to :season, optional: true
  validates :Tournament_name, presence: true, uniqueness: { scope: :season, message: "Statement already exists" }
end
