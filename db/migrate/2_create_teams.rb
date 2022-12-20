class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :Team_name
      t.string :Shortened_team_name

      t.timestamps
    end
  end
end
