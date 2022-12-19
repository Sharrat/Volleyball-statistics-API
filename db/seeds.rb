# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#  movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#  Character.create(name: "Luke", movie: movies.first)

#SEASONS
seasons = Array[Season]
(1..5).each { |a|
  seasons.append(Season.create(Season_name: '202' + a.to_s + '/202' + (a + 1).to_s, Shortened_season_name: '2' + a.to_s + '/2' + (a + 1).to_s))
}

#TEAMS & PLAYERS
teams = Array[Team]
players = Array[Player]

10.times do
  teams.append(Team.create(Team_name: team1 = Faker::Team.name , Shortened_team_name: team1[0, 2].upcase + team1.reverse[0, 1].upcase))
  10.times do
  players.append(Player.create(name: Faker::Name.first_name, surname: Faker::Name.last_name , team_id: Team.last.id ))
  end
end

#TOURNAMENT
tournaments = Array[Tournament]
tournaments_loop = 0
tournaments_max_loop = 0

while tournaments_loop < 10 and tournaments_max_loop < 100
  random_season = Season.all.sample
  random_name = Faker::WorldCup.group + ' Volleyball Cup'+ random_season.Season_name

  if not Tournament.exists?(tournament_name: random_name, season_id: random_season.id)
    tournaments.append(Tournament.create(tournament_name: random_name, season_id: random_season.id))
    tournaments_loop += 1
    tournaments_max_loop = 0
  else
    tournaments_max_loop += 1
  end
end


#TOURNAMENT_STAGES

tournament_stages = Array[TournamentStage]

for i in 1..(Tournament.count) do
  tournament_stages.append(TournamentStage.create(stage_name: "Preliminary round", tournament_id: i))
  tournament_stages.append(TournamentStage.create(stage_name: "Quarterfinals", tournament_id: i))
  tournament_stages.append(TournamentStage.create(stage_name: "Semifinals", tournament_id: i))
  tournament_stages.append(TournamentStage.create(stage_name: "Bronze-medal game", tournament_id: i))
  tournament_stages.append(TournamentStage.create(stage_name: "Gold-medal game", tournament_id: i))
end


#USERS
users = Array[User]

5.times do
  username = Faker::Name.name
#
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

#STAGE_ROUNDS
stage_rounds = Array[StageRound]

window = TournamentStage.count
for k in 1..window do
  if TournamentStage.exists?(id: k)
    for i in 1..2 do
      if not StageRound.exists?(round_name: "Round #{i}", tournament_stage_id: k)
        stage_rounds.append(
          StageRound.create(
            round_name: "Round #{i}",
            tournament_stage_id: k
          )
        )
      end
    end
  else
    window += 1
  end
end

#STAGE_TEAMS

stage_teams = Array[StageTeam]

for i in 1..(TournamentStage.count) do
  if TournamentStage.find(i).stage_name == "Preliminary round"
    16.times do
      stage_teams.append(StageTeam.create(team_id: Team.all.sample.id, tournament_stage_id: i))
    end
  end
  if TournamentStage.find(i).stage_name == "Quarterfinals"
    8.times do
      stage_teams.append(StageTeam.create(team_id: Team.all.sample.id, tournament_stage_id: i))
    end
  end
  if TournamentStage.find(i).stage_name == "Semifinals"
    4.times do
      stage_teams.append(StageTeam.create(team_id: Team.all.sample.id, tournament_stage_id: i))
    end
  end
  if TournamentStage.find(i).stage_name == "Bronze-medal game"
    2.times do
      stage_teams.append(StageTeam.create(team_id: Team.all.sample.id, tournament_stage_id: i))
    end
  end
  if TournamentStage.find(i).stage_name == "Gold-medal game"
    2.times do
      stage_teams.append(StageTeam.create(team_id: Team.all.sample.id, tournament_stage_id: i))
    end
  end
end
