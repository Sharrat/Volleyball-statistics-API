# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# SEASONS
seasons = Array[Season]
(1..5).each { |a|
  seasons.append(Season.create(Season_name: '202' + a.to_s + '/202' + (a + 1).to_s, Shortened_season_name: '2' + a.to_s + '/2' + (a + 1).to_s))
}

# TEAMS & PLAYERS
teams = Array[Team]
players = Array[Player]

10.times do
  teams.append(Team.create(Team_name: team1 = Faker::Team.name , Shortened_team_name: team1[0, 2].upcase + team1.reverse[0, 1].upcase))
  10.times do
  players.append(Player.create(name: Faker::Name.first_name, surname: Faker::Name.last_name , team_id: Team.last.id ))
  end
end

#USERS
users = Array[User]

5.times do
  username = Faker::Name.name

  if not User.exists?(username)
    users.append(
      User.create(
        username: username,
        password: Faker::Blockchain::Tezos.account,
        is_admin: random_boolean = [true, false].sample
        )
    )
  end
end
