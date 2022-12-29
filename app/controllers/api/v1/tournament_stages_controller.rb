module Api
  module V1
    class TournamentStagesController < ApplicationController
      def index
        tournament_stages = TournamentStage.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Loaded tournament stages',
                      data: tournament_stages},status: :ok
      end

      def show
        tournament_stage = TournamentStage.find(params[:id])
        tournament = Tournament.find(tournament_stage.tournament_id)
        render json: {status: 'SUCCESS', message:'Tournament stage loaded',
                      data:{"id": tournament_stage.id, "stage_name": tournament_stage.stage_name,
                        Tournament: {"id": tournament.id, "Tournament_name": tournament.tournament_name, "season_id": tournament.season_id}}},status: :ok
      end

      def create
        tournament_stage = TournamentStage.new(tournament_stage_params)

        tournament = Tournament.find(params[:tournament_id])
        if tournament_stage.save
          render json: {status: 'SUCCESS', message:'TournamentStage saved',
                        data:{"id": tournament_stage.id, "stage_name": tournament_stage.stage_name, "tournament_id": tournament.id}}, status: :ok
        else
          render json: {status: 'ERROR', message:'Tournament stage not saved', data: tournament_stage.errors}, status: :unprocessable_entity
        end
      end

      def destroy
        tournament_stage = TournamentStage.find(params[:id])
        if tournament_stage.destroy
          render json: {status: 'SUCCESS', message:'Tournament stage deleted'}, status: :ok
        else
          render json: {status: 'ERROR', message:'Tournament stage not deleted', data: tournament_stage.errors}, status: :unprocessable_entity
        end
      end

      def update
          tournament_stage = TournamentStage.find(params[:id])
          if tournament_stage.update(tournament_stage_params)
            tournament = Tournament.find(params[:tournament_id])
            render json: {status: 'SUCCESS', message:'Tournament stage updated',
                          data:{"id": tournament_stage.id, "stage_name": tournament_stage.stage_name, "tournament_id": tournament.id}}, status: :ok
          else
            render json: {status: 'ERROR', message:'Tournament stage not updated', data: tournament_stage.errors}, status: :unprocessable_entity
          end
      end

      private

      def tournament_stage_params
        params.permit(:stage_name, :tournament_id)
      end
    end
  end
end
