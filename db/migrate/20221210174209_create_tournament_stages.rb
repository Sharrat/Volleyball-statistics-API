class CreateTournamentStages < ActiveRecord::Migration[7.0]
  def change
    create_table :tournament_stages do |t|
      t.string :stage_name, null: false
      t.belongs_to :tournament, foreign_key: true

      t.timestamps
    end
    add_index :tournaments, [:stage_name, :tournament_id], unique: true
  end
end
