module Api
  module V1
    class StageTeamsController < ApplicationController

      def index
        if user_signed_in? || admin_signed_in?
          stage_teams = StageTeam.order('created_at DESC')
          render json: {status: 'SUCCESS', message:'Loaded stage teams', data:stage_teams},status: :ok
        else
          render json: {status: 'Unauthorized', message:'Please sign in or sign up', data:401},status => 401
        end

      end

      def show
        if user_signed_in? || admin_signed_in?
          stage_team = StageTeam.find(params[:id])
          render json: {status: 'SUCCESS', message:'Loaded stage team', data:stage_team},status: :ok
        else
          render json: {status: 'Unauthorized', message:'Please sign in or sign up', data:401},status => 401
        end
      end

      def create
        if admin_signed_in?
          stage_team = StageTeam.new(stage_team_params)
          if stage_team.save
            render json: {status: 'SUCCESS', message:'Saved stage team', data:stage_team},status: :ok
          else
            render json: {status: 'ERROR', message:'Stage team not saved', data:stage_team.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
      end

      def destroy
        if admin_signed_in?
          stage_team = StageTeam.find(params[:id])
          if stage_team.destroy
            render json: {status: 'SUCCESS', message:'Deleted stage team', data:stage_team},status: :ok
          else
            render json: {status: 'ERROR', message:'Stage team not deleted', data:stage_team.errors}, status: :unprocessable_entity
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
      end

      def update
        if admin_signed_in?
          stage_team = StageTeam.find(params[:id])
          if stage_team.update(stage_team_params)
            render json: {status: 'SUCCESS', message:'Updated stage team', data:stage_team},status: :ok
          else
            render json: {status: 'ERROR', message:'Stage team not updated', data:stage_team.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
      end


      private
        def stage_team_params
          params.permit(:team_id, :tournament_stage_id)
        end
      end
  end
end
