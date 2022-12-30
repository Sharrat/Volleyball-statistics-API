class CreateMatchSets < ActiveRecord::Migration[7.0]
  def change
    create_table :match_sets do |t|
      t.references :match, null: false, foreign_key: true
      t.integer :set_number
      t.string :result

      t.timestamps
    end
  end
end
