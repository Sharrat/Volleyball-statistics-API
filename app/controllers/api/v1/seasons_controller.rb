module Api
  module V1
    class SeasonsController < ApplicationController
      def index
        if user_signed_in? || admin_signed_in?
          seasons = Season.order('created_at DESC')
          render json: {status: 'SUCCESS', message:'Loaded seasons', data:seasons},status: :ok
        else
          render json: {status: 'Unauthorized', message:'Please sign in or sign up', data:401},status => 401
        end
      end
      def show
        if user_signed_in? || admin_signed_in?
          season = Season.find(params[:id])
          render json: {status: 'SUCCESS', message:'Loaded seasons', data:season},status: :ok
        else
          render json: {status: 'Unauthorized', message:'Please sign in or sign up', data:401},status => 401
        end
      end
      def create
        if admin_signed_in?
          season = Season.new(season_params)
          if season.save
            render json: {status: 'SUCCESS', message:'Saved season', data:season},status: :ok
          else
            render json: {status: 'ERROR', message:'season not saved', data:season.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
      end
      def destroy
        if admin_signed_in?
          season = Season.find(params[:id])
          season.destroy
          render json: {status: 'SUCCESS', message:'Deleted season', data:season},status: :ok
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
      end
      def update
        if admin_signed_in?
          season = Season.find(params[:id])
          if season.update(season_params)
            render json: {status: 'SUCCESS', message:'Updated season', data:season},status: :ok
          else
            render json: {status: 'ERROR', message:'Season not updated', data:season.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
      end
      private
      def season_params
        params.permit(:Season_name, :Shortened_season_name)
      end
    end
  end
end