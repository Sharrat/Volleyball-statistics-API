class CreateTournamentStages < ActiveRecord::Migration[7.0]
  def change
    create_table :tournament_stages do |t|
      t.string :stage_name, null: false
      t.references :tournament, null: false, foreign_key: true

      t.timestamps
    end
  end
end
