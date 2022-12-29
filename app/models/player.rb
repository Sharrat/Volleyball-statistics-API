class Player < ApplicationRecord
  validates :name, presence: true
  validates :surname, presence: true
  belongs_to :team
  validates :team, presence: true
end
