module Api
  module V1
    class TeamsController < ApplicationController
      def index
        if user_signed_in? || admin_signed_in?
          teams = Team.order('created_at DESC')
          render json: {status: 'SUCCESS', message:'Loaded teams', data:teams},status: :ok
        else
          render json: {status: 'Unauthorized', message:'Please sign in or sign up', data:401},status => 401
        end

      end
      def show
        if user_signed_in? || admin_signed_in?
          team = Team.find(params[:id])
          render json: {status: 'SUCCESS', message:'Loaded teams', data:team},status: :ok
        else
          render json: {status: 'Unauthorized', message:'Please sign in or sign up', data:401},status => 401
        end

      end
      def create
        if admin_signed_in?
          team = Team.new(team_params)
          if team.save
            render json: {status: 'SUCCESS', message:'Saved team', data:team},status: :ok
          else
            render json: {status: 'ERROR', message:'Team not saved', data:team.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
      end
      def destroy
        if admin_signed_in?
          team = Team.find(params[:id])
          if team.destroy
            render json: {status: 'SUCCESS', message:'Deleted team', data:team},status: :ok
          else
            render json: {status: 'ERROR', message:'Team not deleted', data:team.errors},status: :conflict
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
      end
      def update
        if admin_signed_in?
          team = Team.find(params[:id])
          if team.update(team_params)
            render json: {status: 'SUCCESS', message:'Updated team', data:team},status: :ok
          else
            render json: {status: 'ERROR', message:'Team not updated', data:team.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
      end
      private
      def team_params
        params.permit(:Team_name, :Shortened_team_name)
      end
    end
  end
end
