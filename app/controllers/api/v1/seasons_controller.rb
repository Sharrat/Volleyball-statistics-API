module Api
  module V1
    class SeasonsController < ApplicationController
      def index
        seasons = Season.order('created_at DESC')
        render json: {status: 'SUCCESS', message:'Loaded seasons', data:seasons},status: :ok
      end
      def show
        season = Season.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded seasons', data:season},status: :ok
      end
      def create
        season = Season.new(season_params)
        if season.save
          render json: {status: 'SUCCESS', message:'Saved season', data:season},status: :ok
        else
          render json: {status: 'ERROR', message:'season not saved', data:season.errors},status: :unprocessable_entity
        end
      end
      def destroy
        season = Season.find(params[:id])
        season.destroy
        render json: {status: 'SUCCESS', message:'Deleted season', data:season},status: :ok
      end
      def update
        season = Season.find(params[:id])
        if season.update(season_params)
          render json: {status: 'SUCCESS', message:'Updated season', data:season},status: :ok
        else
          render json: {status: 'ERROR', message:'Season not updated', data:season.errors},status: :unprocessable_entity
        end
      end
      private
      def season_params
        params.permit(:Season_name, :Shortened_season_name)
      end
    end
  end
end