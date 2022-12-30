class CreateSeasons < ActiveRecord::Migration[7.0]
  def change
    create_table :seasons do |t|
      t.string :Season_name, null: false
      t.string :Shortened_season_name, null: false

      t.timestamps
    end
  end
end
