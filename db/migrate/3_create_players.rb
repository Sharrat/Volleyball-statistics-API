class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.string :surname, null: false
      t.references :team, null: false, foreign_key: true
      t.timestamps
    end
  end
end
