class CreateStageRounds < ActiveRecord::Migration[7.0]
  def change
    create_table :stage_rounds do |t|
      t.string :round_name
      t.references :tournament_stage, null: false, foreign_key: true

      t.timestamps
    end

  end
end
