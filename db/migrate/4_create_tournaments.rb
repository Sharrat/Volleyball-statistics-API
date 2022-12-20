class CreateTournaments < ActiveRecord::Migration[7.0]
  def change
    create_table :tournaments do |t|
      t.string :tournament_name, null: false
      t.references :season, foreign_key: true
      #t.index
      t.timestamps
    end
  end
end
