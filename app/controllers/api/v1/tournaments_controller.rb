module Api
  module V1
    class TournamentsController < ApplicationController
      def index
        if user_signed_in? || admin_signed_in?
          tournaments = Tournament.order('created_at DESC');
          render json: {status: 'SUCCESS', message:'Loaded tournaments', data:tournaments},status: :ok
        else
          render json: {status: 'Unauthorized', message:'Please sign in or sign up', data:401},status => 401
        end

      end

      def show
        if user_signed_in? || admin_signed_in?
          tournament = Tournament.find(params[:id])
          season = Season.find(tournament.season_id)
          render json: {status: 'SUCCESS', message:'Tournament loaded',
                        data:{"id": tournament.id, "tournament_name": tournament.tournament_name,
                              Season: {"id": season.id, "Season_name": season.Season_name, "Shortened_season_name": season.Shortened_season_name}}},status: :ok
        else
          render json: {status: 'Unauthorized', message:'Please sign in or sign up', data:401},status => 401
        end

      end

      def create
        if admin_signed_in?
          tournament = Tournament.new(tournament_params)

          season = Season.find(params[:season_id])
          if tournament.save
            render json: {status: 'SUCCESS', message:'Tournament saved',
                          data:{"id": tournament.id, "tournament_name": tournament.tournament_name, "season_id": season.id}}, status: :ok
          else
            render json: {status: 'ERROR', message:'Tournament not saved', data:tournament.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end

      end

      def destroy
        if admin_signed_in?
          tournament = Tournament.find(params[:id])
          if tournament.destroy
            render json: {status: 'SUCCESS', message:'Tournament deleted'}, status: :ok
          else
            render json: {status: 'ERROR', message:'Tournament not deleted', data:tournament.errors},status: :unprocessable_entity

          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end

      end

      def update
        if admin_signed_in?
          tournament = Tournament.find(params[:id])
          season = Season.find(params[:season_id])
          if tournament.update(tournament_params)
            render json: {status: 'SUCCESS', message:'Tournament updated',
                          data:{"id": tournament.id, "tournament_name": tournament.tournament_name, "season_id": season.id}}, status: :ok
          else
            render json: {status: 'ERROR', message:'Tournament not updated', data:tournament.errors},status: :unprocessable_entity

          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end

      end

      private

      def tournament_params
        params.permit(:tournament_name, :season_id)
      end
    end
  end
end
