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

#Stworzenie 30 druzyn. Dla kazdego zaspolu tworzonych jest 10 zawodnikow

teams = Array[Team]
players = Array[Player]

30.times do
  teams.append(Team.create(Team_name: team1 = Faker::Team.name , Shortened_team_name: team1[0, 2].upcase + team1.reverse[0, 1].upcase))
  10.times do
  players.append(Player.create(name: Faker::Name.first_name, surname: Faker::Name.last_name , team_id: Team.last.id )) #kazdy gracz jest oddawany do ostatnio stworzonej druzyny
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

#TOURNAMENT_TEAMS
#Dla kazdego turnieju dobieranych jest losowo 16 druzyn, ktore sie nie powtarzaja
tournament_teams = Array[TournamentTeam]

for i in 1..(Tournament.count) do                                                #petla ktora sie wykona tyle razy ile jest turniejow
  if  TournamentTeam.all.any? { |hash| hash[:tournament_id] == i }               #sprawdzenie czy w TournamentTeam sa juz dodane druzyny(Team_ID) dla turnieju(Tournament_ID)
  else
  choosen_teams = []                                                             #stworzenie tabeli z wybranymi druzynami dla turnieju i
  while choosen_teams.count <= 16                                                #wybieranie druzyn do momentu, az bedzie ich 16 <-mozna zmienic ich ilosc
    random_team = Team.all.sample.id                                             #wybranie losowej druzyny (Team_ID)
    choosen_teams.append(random_team) unless choosen_teams.include?(random_team) #jezeli druzyna zostlala juz wybrana to jest pomijana, jesli nie to dodawana jest do tabeli wybranych druzyn
  end

  for j in 1..(choosen_teams.count) do
    tournament_teams.append(TournamentTeam.create(tournament_id: i, team_id: choosen_teams[j])) #przyporzadkowanie wybranych druzyn do turnieju
  end
  end
end


  #MATCHES
    matches = Array[Match]
    stage_round_count = StageRound.count
    team_count = Team.count/2 - 1

    for i in 1..(stage_round_count) do
      if StageRound.exists?(id: i)
        for j in 1..(team_count)
          if Team.exists?(id: j)
            team1 = Team.find(j)
            team2 = Team.all.sample
            while team1 == team2
              team2 = Team.all.sample
            end
          else
            team_count += 1
          end
          if not Match.exists?(round_id: j, team1_id: team1.id, team2_id: team2.id)
            #find date string
            stage_round = StageRound.find(i)
            tournament_stage = TournamentStage.find(stage_round.tournament_stage_id)
            tournament = Tournament.find(tournament_stage.tournament_id)
            season = Season.find(tournament.season_id)
            # string to date
            date = "01-01-20"
            date.concat(season.Shortened_season_name[0,2])
            date = date.to_date + rand(1..256).days
            result = rand(0..3).to_s << ":" << rand(0..3).to_s
            matches.append(
              Match.create(round_id: j, team1_id: team1.id, team2_id: team2.id,
                             match_name: team1.Team_name << " vs " << team2.Team_name,
                             match_date: date,
                             result: (result))
            )
          end
        end
      else
        stage_round_count += 1
      end
    end

#match_sets

match_sets = Array[MatchSet]
for i in 1..(Match.count)
  t1_win_count = Match.find(i).result[0].to_i
  t2_win_count = Match.find(i).result[-1].to_i
  set_num = 0
    for j in 1..t1_win_count
      wyn1 = rand(25..40)
      if(wyn1 == 25)
        wyn2 = rand(0..23)
      else
        wyn2 = wyn1-2
      end
      result_str = wyn1.to_s << ":" << wyn2.to_s
      set_num = set_num + 1
      match_sets.append(MatchSet.create(match_id: i, set_number: set_num, result: result_str ))
    end
    for j in 1..t2_win_count
      wyn2 = rand(25..40)
      if(wyn2 == 25)
        wyn1 = rand(0..23)
      else
        wyn1 = wyn2-2
      end
      result_str = wyn1.to_s << ":" << wyn2.to_s
      set_num = set_num + 1
      match_sets.append(MatchSet.create(match_id: i, set_number: set_num, result: result_str ))
    end
end
