module Api
  module V1
    class TournamentTeamsController < ApplicationController

      def index
        tournament_teams = TournamentTeam.order('created_at ASC')
        render json: {status: 'SUCCESS', message:'Loaded tournament teams', data:tournament_teams},status: :ok
      end

      def show
        if TournamentTeam.exists?(params[:id])
          tournament_team = TournamentTeam.find(params[:id])
          render json: {status: 'SUCCESS', message:'Loaded tournament team', data:tournament_team},status: :ok
        else
          render json: {status: 'ERROR', message:'Tournament team not loaded', data:{"id": ["must exist"]}},status: :not_found
        end
      end

      def create
        if Tournament.exists?(params[:tournament_id]) && Team.exists?(params[:team_id])
          tournament_team = TournamentTeam.new(tournament_team_params)
          if tournament_team.save
            render json: {status: 'SUCCESS', message:'Saved tournament team', data:tournament_team},status: :ok
          else
            render json: {status: 'ERROR', message:'Tournament team not saved', data:tournament_team.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'ERROR', message:'Tournament team not saved', data:{"tournament": ["must exist"], "team": ["must exist"]}},status: :not_found
        end
      end


      def update
        if TournamentTeam.exists?(params[:id])
          tournament_team = TournamentTeam.find(params[:id])
          if tournament_team.update(tournament_team_params)
            render json: {status: 'SUCCESS', message:'Updated tournament team', data:tournament_team},status: :ok
          else
            render json: {status: 'ERROR', message:'Tournament team not updated', data:tournament_team.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'ERROR', message:'Tournament team not deleted', data:{"id": ["must exist"]}},status: :not_found
        end
      end

      def destroy
        if TournamentTeam.exists?(params[:id])
          tournament_team = TournamentTeam.find(params[:id])
          if tournament_team.destroy
            render json: {status: 'SUCCESS', message:'Deleted tournament team', data:tournament_team},status: :ok
          else
            render json: {status: 'ERROR', message:'Tournament team not deleted', data:tournament_team.errors}, status: :unprocessable_entity
          end
        else
          render json: {status: 'ERROR', message:'Tournament team not updated', data:{"id": ["must exist"]}},status: :not_found
        end
      end

      private
      def tournament_team_params
        params.permit(:team_id, :tournament_id)
      end

    end
  end
end
