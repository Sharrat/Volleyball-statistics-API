class CreateTournamentStages < ActiveRecord::Migration[7.0]
  def change
    create_table :tournament_stages do |t|
      t.string :stage_name, null: false
      t.belongs_to :tournament, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tournament_stages, [:stage_name, :tournament_id], unique: true
  end
end
