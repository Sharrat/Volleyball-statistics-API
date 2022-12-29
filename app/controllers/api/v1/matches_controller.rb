module Api
  module V1
    class MatchesController < ApplicationController
      def index
        matches = Match.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Loaded matches',
                      data: matches},status: :ok
      end

      def show
        if Match.exists?(params[:id])
          match = Match.find(params[:id])
          render json: {status: 'SUCCESS', message:'Match loaded',
                        data:{"id": match.id, "stage_name": match.match_name, "round_id": match.round_id,"match_date": match.match_date,
                              "team1_id": match.team1_id, "team2_id": match.team2_id, "result": match.result}},status: :ok
        else
          render json: {status: 'ERROR', message:'Match not loaded', data:{"match": ["must exist"]}}, status: :not_found
        end
      end

      def create
        match = Match.new(match_params)

        if match.save
          render json: {status: 'SUCCESS', message:'Match saved',
                        data:{"id": match.id, "stage_name": match.match_name, "round_id": match.round_id,"match_date": match.match_date,
                              "team1_id": match.team1_id, "team2_id": match.team2_id, "result": match.result}},status: :ok
        else
          render json: {status: 'ERROR', message:'Match not saved', data: match.errors}, status: :unprocessable_entity
        end
      end

      def destroy
        if Match.exists?(params[:id])
          match = Match.find(params[:id])
          if match.destroy
            render json: {status: 'SUCCESS', message:'Match deleted'}, status: :ok
          else
            render json: {status: 'ERROR', message:'Match not deleted', data: match.errors}, status: :unprocessable_entity
          end
        else
          render json: {status: 'ERROR', message:'Match not deleted', data:{"match": ["must exist"]}}, status: :not_found
        end
      end

      def update
        if Match.exists?(params[:id])
            match = Match.find(params[:id])
            if match.update(match_params)
              render json: {status: 'SUCCESS', message:'Match updated',
                            data:{"id": match.id, "stage_name": match.match_name, "round_id": match.round_id,"match_date": match.match_date,
                                  "team1_id": match.team1_id, "team2_id": match.team2_id, "result": match.result}},status: :ok
            else
              render json: {status: 'ERROR', message:'Match not updated', data: match.errors}, status: :unprocessable_entity
            end
       else
         render json: {status: 'ERROR', message:'Match not updated', data:{"match": ["must exist"]}}, status: :not_found
       end
      end

      private

      def match_params
        params.permit(:match_name, :round_id, :match_date, :team1_id, :team2_id, :result)
      end
    end
  end
end
