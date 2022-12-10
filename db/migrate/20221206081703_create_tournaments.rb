class CreateTournaments < ActiveRecord::Migration[7.0]
  def change
    create_table :tournaments do |t|
      t.string :Tournament_name
      t.belongs_to :season, foreign_key: true
      #t.index
      t.timestamps
    end
    add_index :tournaments, [:Tournament_name, :season_id], unique: true
  end
end
