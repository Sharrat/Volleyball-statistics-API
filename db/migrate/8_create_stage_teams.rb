class CreateStageTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :stage_teams do |t|
      t.references :team, null: false, foreign_key: true
      t.references :tournament_stage, null: false, foreign_key: true
      t.timestamps
    end
  end
end
