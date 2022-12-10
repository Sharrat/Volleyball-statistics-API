class CreateSeasonOwnerships < ActiveRecord::Migration[7.0]
  def change
    create_table :season_ownerships do |t|
      t.references :season, null: false, foreign_key: true
      #t.references :user, null: false, foreign_key: true #Trzeba najierw stworzyc tabele user bo inaczej nie dziala (chyba?) 
      t.timestamps
    end
  end
end
