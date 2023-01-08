module Api
  module V1
    class PlayersController < ApplicationController
      def index
        if user_signed_in? || admin_signed_in?
          players = Player.order('created_at DESC')
          render json: {status: 'SUCCESS', message:'Loaded players', data:players},status: :ok
        else
          render json: {status: 'Unauthorized', message:'Please sign in or sign up', data:401},status => 401
        end

      end

      def show
        if user_signed_in? || admin_signed_in?
          player = Player.find(params[:id])
          render json: {status: 'SUCCESS', message:'Loaded player', data:player},status: :ok
        else
          render json: {status: 'Unauthorized', message:'Please sign in or sign up', data:401},status => 401
        end

      end

      def create
        if admin_signed_in?
          player = Player.new(player_params)
          if player.save!
            render json: {status: 'SUCCESS', message:'Saved player', data:player},status: :ok
          else
            render json: {status: 'ERROR', message:'Player not saved', data:player.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end

      end

      def destroy
        if admin_signed_in?
          player = Player.find(params[:id])
          player.destroy
          render json: {status: 'SUCCESS', message:'Deleted player', data:player},status: :ok
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
      end

      def update
        if admin_signed_in?
          player = Player.find(params[:id])
          if player.update(player_params)
            render json: {status: 'SUCCESS', message:'Updated player', data:player},status: :ok
          else
            render json: {status: 'ERROR', message:'Player not updated', data:player.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
      end


      private
        def player_params
          params.permit(:name, :surname, :team_id)
        end
      end
  end
  end

