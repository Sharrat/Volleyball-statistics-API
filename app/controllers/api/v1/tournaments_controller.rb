module Api
  module V1
    class TournamentsController < ApplicationController
      def index
        tournaments = Tournament.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Loaded tournaments', data:tournaments},status: :ok
      end

      def show
        if Tournament.exists?(params[:id])
          tournament = Tournament.find(params[:id])
          season = Season.find(tournament.season_id)
          render json: {status: 'SUCCESS', message:'Loaded tournament',
                        data:{"id": tournament.id, "Tournament name": tournament.Tournament_name, "Season": season}},status: :ok
        end
      end
    end
  end
end
