module Api
  module V1
    class TeamStatsController < ApplicationController
      def show
        if user_signed_in? || admin_signed_in?
          tournament=Tournament.find(params[:tournament_id])
          tournament_stage=TournamentStage.where(tournament: tournament)
          stage_round=StageRound.where(tournament_stage: tournament_stage)
          matches_played=Array.new #tworzenie tabel z inforamcjami o meczach zagranych, wygranych i przegranych
          matches_won=Array.new
          matches_lost=Array.new

          #zerowanie tych tabel
          for i in 0..(Team.count-1) do  #Teamy będą numerowane od zera bo tablice zaczynają się od zera
            matches_played[i] = 0
            matches_won[i] = 0
            matches_lost[i] = 0
          end

          match=Match.where(round: stage_round)

          match.each do |match| # pętla po każdym meczu
            matches_played[match.team1_id - 1] += 1 #Pobierany jest numer druzyny team1 i dodawana jest wartosć jeden w zagranych meczach
            matches_played[match.team2_id - 1] += 1 #Pobierany jest numer druzyny team2 i dodawana jest wartosć jeden w zagranych meczach

            if match.result[0] > match.result[2] #sprawdzany jest wynik meczu (np 3:1) - wtedy wygrywa team1
              matches_won[match.team1_id - 1] += 1 #Ilość wygranych meczy przez Team1 zwiększa się o jeden
              matches_lost[match.team2_id - 1] += 1 #Ilość przegranych meczy przez Team2 zwiększa się o jeden
            else match.result[0] <= match.result[2] # znak '=' usunac jak Adam poprawi tabele match i generowanie wyników (teraz może być wygenerowany remis więc znamiem równa się je uwzględniamy)
            matches_won[match.team2_id - 1] += 1
            matches_lost[match.team1_id - 1] += 1
            end
          end


          #W tabeli matches_info przechowywane będą informacje o całych meczach (id, wynik, team1, team2 itp), w których brała udział drużyna podana w parametrze
          matches_info = Match.where(round: stage_round).and(Match.where('team1_id = ? OR team2_id = ?', params[:id].to_i, params[:id].to_i)) #porównywanie czy team1_id==params[:id] lub team2_id==params[:id]; params[:id] jest zamieniane na int

          matches_info_ids = matches_info.map(&:id) #za pomocą mapy z każdgo meczu wyciągane jest id meczu i zapisywane w matches_info_ids
          set_info = MatchSet.where(match_id: matches_info_ids) #na podstawie matches_info_ids pobierane są tylko te sety, w których zagrała drużyna podana w params[:id]

          #zmienne ze statystykami na temat setów dla drużyny params[:id]
          sets_won = 0
          sets_lost = 0
          points_won = 0
          points_lost = 0
          small_points_won = 0
          small_points_lost = 0


          set_info.each do |set| #petla po kazdym secie, który zagrał team podany w params[:id]
            result_split = set.result.split(":") #dzielenie stringa z wynikiem setu na dwie części
            left = result_split[0].to_i #punkty po lewej stronie od znaku : zamienione na int
            right = result_split[1].to_i #punkty po prawej stronie od znaku : zamienione na int

            set_team1_id=0
            matches_info.each do |mi|
              if set.match_id == mi.id
                set_team1_id = mi.team1_id
              end
            end


            if params[:id].to_i == set_team1_id #sytuacja gdy podany team w params[:id] jest pod numerem team1
              # params[:id] vs team2
              if left > right #gdy druzyna ma w secie więcej punktów to go wygrała
                sets_won += 1
                points_won += left
                points_lost += right
                small_points_won += left - right
              else
                sets_lost += 1
                points_won += left
                points_lost += right
                small_points_lost += right - left

              end
            else #sytuacja gdy podany team w params[:id] jest pod numerem team2
              # team1 vs params[:id]
              if left > right
                sets_lost += 1
                points_won += right
                points_lost += left
                small_points_lost += left - right
              else
                sets_won += 1
                points_won += right
                points_lost += left
                small_points_won += right - left
              end
            end
          end


          suma = matches_info.map do |match| # w 'suma' zapisywane jest info o meczu i wszystkich setach w tym meczu
            {
              "Match ID": match.id,
              "Match name": match.match_name,
              "Round ID": match.round_id,
              "Match date": match.match_date,
              "Team 1 ID": match.team1_id,
              "Team 2 ID": match.team2_id,
              "Result": match.result,
              "Set": set_info.map do |set| # z wszystkich setów, które zagrała drużyna podana w params[:id]
                if set.match_id == match.id #wybierane są tylko te, które należą do aktualnego meczu
                  {
                    "Set ID": set.id,
                    "Match ID": set.match_id,
                    "Set number": set.set_number,
                    "Result": set.result
                  }
                end
              end.compact #usuwa nulle
            }
          end

          # matches_won.map.with_index.sort.map(&:last) #Lista pozycji jakie zajął każdy team posortowana rosnąco
          # { |a, b| b <=> a } odwracanie tablicy - teraz jest posortowana malejąco
          matches_won_sorted_id = matches_won.map.with_index.sort{ |a, b| b <=> a }.map(&:last)
          # W tablicy matches_won_sorted_id index odpowiada numerowi drużyny-1(bo tablica zaczyna się od zera; Czyli team o id=1 będzie na pozycji matches_won_sorted_id[0])
          # Natomiast wartość przypisana do indeksu odpowiada miejscu jakie drużyna zajmuje
          #przykład:
          # matches_won = [1, 3, 2, 4]
          # matches_won_sorted_id = matches_won.map.with_index.sort{ |a, b| b <=> a }.map(&:last)
          # Wynik=> [3, 1, 2, 0]

          position=matches_won_sorted_id.index(params[:id].to_i-1) # Wczytywanie jaka pozycje w tabeli zajmuje druzyna o id params[:id](ale numery zaczynaja się od 0 więc trzeba odjąć 1)
          position+=1 #zwrócony indeks jest od 0 więc dodajemy 1 (miejsca w tabeli liczone są od jeden - nie ma miejsca zerowego)

          # Rozpiska wszystkich danych do json-a
          #
          # 'Possition':possition
          # 'Matches played':matches_played[params[:id].to_i-1]
          # 'Matches won': matches_won[params[:id].to_i-1]
          # 'Matches lost': matches_lost[params[:id].to_i-1]
          # 'Match': suma
          # 'Sets won': sets_won
          # 'Sets lost': sets_lost
          # 'Points won': points_won
          # 'Points lost': points_lost
          # 'Small points won': small_points_won
          # 'Small points lost': small_points_lost


          render json: {status: 'SUCCESS', message:'Loaded team stats', data: {'Position':position,'Matches played':matches_played[params[:id].to_i-1], 'Matches won': matches_won[params[:id].to_i-1], 'Matches lost': matches_lost[params[:id].to_i-1], 'Match': suma, 'Sets won': sets_won, 'Sets lost': sets_lost, 'Points won': points_won, 'Points lost': points_lost, 'Small points won': small_points_won, 'Small points lost': small_points_lost }}, status: :ok
        else
          render json: {status: 'Unauthorized', message:'Please sign in or sign up', data:401},status => 401
        end

      end


    end
  end
end




