module Api
  module V1
    class TeamsController < ApplicationController
      def index
        teams = Team.order('created_at DESC')
        render json: {status: 'SUCCESS', message:'Loaded teams', data:teams},status: :ok
      end
      def show
        team = Team.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded teams', data:team},status: :ok
      end
      def create
        team = Team.new(team_params)
        if team.save
          render json: {status: 'SUCCESS', message:'Saved team', data:team},status: :ok
        else
          render json: {status: 'ERROR', message:'Team not saved', data:team.errors},status: :unprocessable_entity
        end
      end
      def destroy
        team = Team.find(params[:id])
        if team.destroy
          render json: {status: 'SUCCESS', message:'Deleted team', data:team},status: :ok
        else
          render json: {status: 'ERROR', message:'Team not deleted', data:team.errors},status: :conflict
        end
      end
      def update
        team = Team.find(params[:id])
        if team.update(team_params)
          render json: {status: 'SUCCESS', message:'Updated team', data:team},status: :ok
        else
          render json: {status: 'ERROR', message:'Team not updated', data:team.errors},status: :unprocessable_entity
        end
      end
      private
      def team_params
        params.permit(:Team_name, :Shortened_team_name)
      end
    end
  end
end
