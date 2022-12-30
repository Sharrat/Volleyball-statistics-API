module Api
  module V1
    class StageTeamsController < ApplicationController

      def index
        stage_teams = StageTeam.order('created_at DESC')
        render json: {status: 'SUCCESS', message:'Loaded stage teams', data:stage_teams},status: :ok
      end

      def show
        stage_team = StageTeam.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded stage team', data:stage_team},status: :ok
      end

      def create
        stage_team = StageTeam.new(stage_team_params)
          if stage_team.save
            render json: {status: 'SUCCESS', message:'Saved stage team', data:stage_team},status: :ok
          else
            render json: {status: 'ERROR', message:'Stage team not saved', data:stage_team.errors},status: :unprocessable_entity
          end
      end

      def destroy
        stage_team = StageTeam.find(params[:id])
        if stage_team.destroy
          render json: {status: 'SUCCESS', message:'Deleted stage team', data:stage_team},status: :ok
        else
          render json: {status: 'ERROR', message:'Stage team not deleted', data:stage_team.errors}, status: :unprocessable_entity
        end
      end

      def update
        stage_team = StageTeam.find(params[:id])
        if stage_team.update(stage_team_params)
          render json: {status: 'SUCCESS', message:'Updated stage team', data:stage_team},status: :ok
        else
          render json: {status: 'ERROR', message:'Stage team not updated', data:stage_team.errors},status: :unprocessable_entity
        end
      end


      private
        def stage_team_params
          params.permit(:team_id, :tournament_stage_id)
        end
      end
  end
end
