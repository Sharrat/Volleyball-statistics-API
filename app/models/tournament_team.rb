class TournamentTeam < ApplicationRecord
  #belongs_to :tournament #Trzeba najpierw stworzyc tabele tournament bo inaczej nie dziala (chyba?)
  belongs_to :team
end
