class CreateTournamentTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :tournament_teams do |t|
      t.references :tournament, null: false, foreign_key: true #Trzeba najpierw stworzyc tabele match bo inaczej nie dziala (chyba?)
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
