module Api
  module V1
    class TournamentTeamsController < ApplicationController

      def index
        if user_signed_in? || admin_signed_in?
          tournament_teams = TournamentTeam.order('created_at ASC')
          render json: {status: 'SUCCESS', message:'Loaded tournament teams', data:tournament_teams},status: :ok
        else
          render json: {status: 'Unauthorized', message:'Please sign in or sign up', data:401},status => 401
        end
      end

      def show
        if user_signed_in? || admin_signed_in?
          tournament_team = TournamentTeam.find(params[:id])
          render json: {status: 'SUCCESS', message:'Loaded tournament team', data:tournament_team},status: :ok
        else
          render json: {status: 'Unauthorized', message:'Please sign in or sign up', data:401},status => 401
        end
      end

      def create
        if admin_signed_in?
          tournament_team = TournamentTeam.new(tournament_team_params)
          if tournament_team.save
            render json: {status: 'SUCCESS', message:'Saved tournament team', data:tournament_team},status: :ok
          else
            render json: {status: 'ERROR', message:'Tournament team not saved', data:tournament_team.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
      end


      def update
        if admin_signed_in?
          tournament_team = TournamentTeam.find(params[:id])
          if tournament_team.update(tournament_team_params)
            render json: {status: 'SUCCESS', message:'Updated tournament team', data:tournament_team},status: :ok
          else
            render json: {status: 'ERROR', message:'Tournament team not updated', data:tournament_team.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
    end

      def destroy
        if admin_signed_in?
          tournament_team = TournamentTeam.find(params[:id])
          if tournament_team.destroy
            render json: {status: 'SUCCESS', message:'Deleted tournament team', data:tournament_team},status: :ok
          else
            render json: {status: 'ERROR', message:'Tournament team not deleted', data:tournament_team.errors}, status: :unprocessable_entity
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
      end

      private
      def tournament_team_params
        params.permit(:team_id, :tournament_id)
      end

    end
  end
end
