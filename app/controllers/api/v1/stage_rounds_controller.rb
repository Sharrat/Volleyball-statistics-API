module Api
  module V1
    class StageRoundsController < ApplicationController
      def index
        stage_rounds = StageRound.order('created_at DESC')
        render json: {status: 'SUCCESS', message:'Loaded stage rounds', data:stage_rounds},status: :ok
      end

#SHOW SINGULAR
      def show
          stage_round = StageRound.find(params[:id])
          render json: {status: 'SUCCESS', message:'Loaded stage round', data:stage_round},status: :ok
      end

#CREATE
      def create
        stage_round = StageRound.new(stage_round_params)
        if stage_round.save
          render json: {status: 'SUCCESS', message:'Saved stage round', data:stage_round},status: :ok
        else
          render json: {status: 'ERROR', message:'Stage round not saved', data:stage_round.errors},status: :unprocessable_entity
        end
      end

#DESTROY
      def destroy
          stage_round = StageRound.find(params[:id])
            if stage_round.destroy
              render json: {status: 'SUCCESS', message:'Deleted stage round', data:stage_round},status: :ok
            else
              render json: {status: 'ERROR', message:'Stage round not deleted', data: stage_round.errors}, status: :unprocessable_entity
            end
      end

#UPDATE
      def update
          stage_round = StageRound.find(params[:id])
          if stage_round.update(stage_round_params)
            render json: {status: 'SUCCESS', message:'Updated stage round', data:stage_round},status: :ok
          else
            render json: {status: 'ERROR', message:'Stage round not updated', data:stage_round.errors},status: :unprocessable_entity
          end
      end

      private
      def stage_round_params
        params.permit(:round_name, :tournament_stage_id)
      end

    end
  end
end
