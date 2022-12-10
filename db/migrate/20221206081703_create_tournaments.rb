class CreateTournaments < ActiveRecord::Migration[7.0]
  def change
    create_table :tournaments do |t|
      t.string :tournament_name, null: false
      t.belongs_to :season, foreign_key: true
      #t.index
      t.timestamps
    end
    add_index :tournaments, [:tournament_name, :season_id], unique: true
  end
end
