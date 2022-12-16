class CreateStageRounds < ActiveRecord::Migration[7.0]
  def change
    create_table :stage_rounds do |t|
      t.string :round_name
      t.belongs_to :tournament_stage, null: false, foreign_key: true
      #t.belongs_to :stage, foreign_key: true, foreign_key: { to_table: :tournament_stage }, null: false

      t.timestamps
    end
    add_index :stage_rounds, [:round_name, :tournament_stage_id], unique: true

  end
end
