module Api
  module V1
    class MatchesController < ApplicationController
      def index
        if user_signed_in? || admin_signed_in?
          matches = Match.order('created_at DESC');
          render json: {status: 'SUCCESS', message:'Loaded matches',
                        data: matches},status: :ok
        else
          render json: {status: 'Unauthorized', message:'Please sign in or sign up', data:401},status => 401
        end
      end

      def show
        if user_signed_in? || admin_signed_in?
          if Match.exists?(params[:id])
            match = Match.find(params[:id])
            render json: {status: 'SUCCESS', message:'Match loaded',
                          data:{"id": match.id, "stage_name": match.match_name, "round_id": match.round_id,"match_date": match.match_date,
                                "team1_id": match.team1_id, "team2_id": match.team2_id, "result": match.result}},status: :ok
          else
            render json: {status: 'ERROR', message:'Match not loaded', data:{"match": ["must exist"]}}, status: :not_found
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in or sign up', data:401},status => 401
        end
      end

      def create
        if admin_signed_in?
          match = Match.new(match_params)

          if match.save
            render json: {status: 'SUCCESS', message:'Match saved',
                          data:{"id": match.id, "stage_name": match.match_name, "round_id": match.round_id,"match_date": match.match_date,
                                "team1_id": match.team1_id, "team2_id": match.team2_id, "result": match.result}},status: :ok
          else
            render json: {status: 'ERROR', message:'Match not saved', data: match.errors}, status: :unprocessable_entity
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
      end

      def destroy
        if admin_signed_in?
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
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
      end

      def update
        if admin_signed_in?
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
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
      end

      private

      def match_params
        params.permit(:match_name, :round_id, :match_date, :team1_id, :team2_id, :result)
      end
    end
  end
end
