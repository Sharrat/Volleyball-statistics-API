class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :Team_name, null: false
      t.string :Shortened_team_name, null: false

      t.timestamps
    end
  end
end
