module Api
  module V1
    class SeasonsController < ApplicationController
      def index
        seasons = Season.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Loaded seasons', data:seasons},status: :ok
      end
    end
  end
end