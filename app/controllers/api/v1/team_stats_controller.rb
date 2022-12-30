module Api
  module V1
    class TeamStatsController < ApplicationController
      def show

        matches_played=Array[]
        matches_won=Array[]
        matches_lost=Array[]
        for i in 1..(Team.count) do
          matches_played[i] = 0
          matches_won[i] = 0
          matches_lost[i] = 0
        end


        for i in 1..(Match.count) do
          matches_played[Match.find(i).team1_id]+=1
          matches_played[Match.find(i).team2_id]+=1

          if(Match.find(i).result[0]>Match.find(i).result[2])
            matches_won[Match.find(i).team1_id]+=1
            matches_lost[Match.find(i).team2_id]+=1
          end
          if(Match.find(i).result[0]<=Match.find(i).result[2]) #= usunac
            matches_won[Match.find(i).team2_id]+=1
            matches_lost[Match.find(i).team1_id]+=1
          end

        end
        matches_played.shift
        matches_won.shift
        matches_lost.shift

        matches_info=Array[]
        for i in 1..(Match.count) do
           if (Match.find(i).team1_id.to_i == params[:id].to_i) ||(Match.find(i).team2_id.to_i == params[:id].to_i)
           matches_info.append(Match.find(i))
          end
        end



        # matches = Match.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded player', data:matches_info},status: :ok
      end



      def index

        matches_played=Array[]
        matches_won=Array[]
        matches_lost=Array[]
        for i in 1..(Team.count) do
          matches_played[i] = 0
          matches_won[i] = 0
          matches_lost[i] = 0
        end


         for i in 1..(Match.count) do
           matches_played[Match.find(i).team1_id]+=1
           matches_played[Match.find(i).team2_id]+=1

           if(Match.find(i).result[0]>Match.find(i).result[2])
             matches_won[Match.find(i).team1_id]+=1
             matches_lost[Match.find(i).team2_id]+=1
           end
           if(Match.find(i).result[0]<=Match.find(i).result[2]) #= usunac
             matches_won[Match.find(i).team2_id]+=1
             matches_lost[Match.find(i).team1_id]+=1
           end

         end
        matches_played.shift
        matches_won.shift
        matches_lost.shift



        render json: {status: 'SUCCESS', message:'Loaded tournament teams', data: matches_lost },status: :ok


          #Nie uwzglednione wyniki meczow - wychodzi np wynik 6-10
          # Uwzglednic mozliwe wyniki

        # Dla danego teamu musimy znaleźć wszystkie mecze
        # Oliczyc ile ich jest, ile wygral ile przegral
        # Wypisac te mecze korzystajac z matches
        # Wypisac sety w danym meczu
        #

      end



    end
  end
end

