module Api
  module V1
    class StageTeamsController < ApplicationController

      def index
        stage_teams = StageTeam.order('created_at DESC')
        render json: {status: 'SUCCESS', message:'Loaded stage teams', data:stage_teams},status: :ok
      end

      def show
        if StageTeam.exists?(params[:id])
          stage_team = StageTeam.find(params[:id])
          render json: {status: 'SUCCESS', message:'Loaded stage team', data:stage_team},status: :ok
        else
          render json: {status: 'ERROR', message:'Stage team not loaded', data:{"id": ["must exist"]}},status: :not_found
        end
      end

      def create
        if TournamentStage.exists?(params[:tournament_stage_id]) && Team.exists?(params[:team_id])
          stage_team = StageTeam.new(stage_team_params)
            if stage_team.save
              render json: {status: 'SUCCESS', message:'Saved stage team', data:stage_team},status: :ok
            else
              render json: {status: 'ERROR', message:'Stage team not saved', data:stage_team.errors},status: :unprocessable_entity
            end
        else
          render json: {status: 'ERROR', message:'Stage team not saved', data:{"tournament_stage": ["must exist"], "team": ["must exist"]}},status: :not_found
        end
      end

      def destroy
        if StageTeam.exists?(params[:id])
          stage_team = StageTeam.find(params[:id])
          if stage_team.destroy
            render json: {status: 'SUCCESS', message:'Deleted stage team', data:stage_team},status: :ok
          else
            render json: {status: 'ERROR', message:'Stage team not deleted', data:stage_team.errors}, status: :unprocessable_entity
          end
        else
          render json: {status: 'ERROR', message:'Stage team not deleted', data:{"id": ["must exist"]}},status: :not_found
        end
      end

      def update
        if StageTeam.exists?(params[:id])
          stage_team = StageTeam.find(params[:id])
          if stage_team.update(stage_team_params)
            render json: {status: 'SUCCESS', message:'Updated stage team', data:stage_team},status: :ok
          else
            render json: {status: 'ERROR', message:'Stage team not updated', data:stage_team.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'ERROR', message:'Stage team not deleted', data:{"id": ["must exist"]}},status: :not_found
        end
      end


      private
        def stage_team_params
          params.permit(:team_id, :tournament_stage_id)
        end
      end
  end
end
