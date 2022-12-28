module Api
  module V1
    class PlayersController < ApplicationController

      def index
        players = Player.order('created_at DESC')
        render json: {status: 'SUCCESS', message:'Loaded players', data:players},status: :ok
      end

      def show
        player = Player.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded player', data:player},status: :ok
      end

      def create
        if Team.exists?(params[:team_id])
        player = Player.new(player_params)
          if player.save
            render json: {status: 'SUCCESS', message:'Saved player', data:player},status: :ok
          else
            render json: {status: 'ERROR', message:'Player not saved', data:player.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'ERROR', message:'Player not saved', data:{"team": ["must exist"]}},status: :not_found
        end
      end

      def destroy
        player = Player.find(params[:id])
        player.destroy
        render json: {status: 'SUCCESS', message:'Deleted player', data:player},status: :ok
      end

      def update
        if Player.exists?(params[:id])
        player = Player.find(params[:id])
        if player.update(player_params)
          render json: {status: 'SUCCESS', message:'Updated player', data:player},status: :ok
        else
          render json: {status: 'ERROR', message:'Player not updated', data:player.errors},status: :unprocessable_entity
        end
        else
          render json: {status: 'ERROR', message:'Player not updated', data:{"id": ["must exist"]}},status: :not_found
        end
      end


      private
        def player_params
          params.permit(:name, :surname, :team_id)
        end
      end
  end
end
