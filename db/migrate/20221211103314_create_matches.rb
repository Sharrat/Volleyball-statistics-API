class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.string :match_name, null: false
      t.date :match_date, null: false
      t.string :result, null: false

      t.belongs_to :round, null: false, foreign_key: { to_table: :stage_rounds }
      t.belongs_to :team1, null: false, foreign_key: { to_table: :teams }
      t.belongs_to :team2, null: false, foreign_key: { to_table: :teams }

      t.timestamps
    end
    # delete later!add_index :matches, [:round_id, :match_date], unique: true
    # delete later! add_index :matches, [:team1, :team2, :match_date], unique: true
    add_index :matches, [:match_name, :match_date], unique: true
  end
end
