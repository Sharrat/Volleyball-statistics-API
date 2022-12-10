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
          render json: {status: 'SUCCESS', message:'Tournament loaded',
                        data:{"id": tournament.id, "tournament_name": tournament.tournament_name,
                          Season: {"id": season.id, "Season_name": season.Season_name, "Shortened_season_name": season.Shortened_season_name}}},status: :ok
        else
          render json: {status: 'ERROR', message:'Tournament not found'}, status: :not_found
        end
      end

      def create
        tournament = Tournament.new(tournament_params)

        if Season.exists?(params[:season_id])
          season = Season.find(params[:season_id])
          if tournament.save
            render json: {status: 'SUCCESS', message:'Tournament saved',
                          data:{"id": tournament.id, "tournament_name": tournament.tournament_name, "season_id": season.id}}, status: :ok
          else
            if Tournament.exists?(tournament_name: params[:tournament_name], season_id: params[:season_id])
              render json: {status: 'ERROR', message:'Tournament already exists'}, status: :conflict
            else
              render json: {status: 'ERROR', message:'Tournament not saved'}, status: :unprocessable_entity
            end
          end
        else
          render json: {status: 'ERROR', message:'Season not found'}, status: :not_found
        end
      end

      def destroy
        if Tournament.exists?(params[:id])
          tournament = Tournament.find(params[:id])
          if tournament.destroy
            render json: {status: 'SUCCESS', message:'Tournament deleted'}, status: :ok
          else
            render json: {status: 'ERROR', message:'Tournament not deleted'}, status: :unprocessable_entity
          end
        else
          render json: {status: 'ERROR', message:'Tournament not found'}, status: :not_found
        end
      end

      def update
        if Tournament.exists?(params[:id])
          if Season.exists?(params[:season_id])
            tournament = Tournament.find(params[:id])
            season = Season.find(params[:season_id])
            if tournament.update(tournament_params)
              render json: {status: 'SUCCESS', message:'Tournament updated',
                            data:{"id": tournament.id, "tournament_name": tournament.tournament_name, "season_id": season.id}}, status: :ok
            else
              render json: {status: 'ERROR', message:'Tournament not updated'}, status: :unprocessable_entity
            end
          else
            render json: {status: 'ERROR', message:'Season not found'}, status: :not_found
          end
        else
          render json: {status: 'ERROR', message:'Tournament not found'}, status: :not_found
        end
      end

      private

      def tournament_params
        params.permit(:tournament_name, :season_id)
      end
    end
  end
end
