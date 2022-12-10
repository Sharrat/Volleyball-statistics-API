class SeasonOwnership < ApplicationRecord
  belongs_to :season
  #belongs_to :user   #Trzeba najpierw stworzyc tabele user bo inaczej nie dziala (chyba?) 
end
