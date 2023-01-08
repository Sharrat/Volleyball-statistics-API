module Api
  module V1
    class MatchSetsController < ApplicationController

      def index
        if user_signed_in? || admin_signed_in?
          match_sets = MatchSet.order('created_at DESC')
          render json: {status: 'SUCCESS', message:'Loaded match sets', data:match_sets},status: :ok
        else
          render json: {status: 'Unauthorized', message:'Please sign in or sign up', data:401},status => 401
        end
      end

      def show
        if user_signed_in? || admin_signed_in?
          if MatchSet.exists?(params[:id])
            match_set = MatchSet.find(params[:id])
            render json: {status: 'SUCCESS', message:'Loaded match set', data:match_set},status: :ok
          else
            render json: {status: 'ERROR', message:'Match set not loaded', data:{"id": ["must exist"]}},status: :not_found
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in or sign up', data:401},status => 401
        end
      end

      def create
        if admin_signed_in?
          if Match.exists?(params[:match_id])
            match_set = MatchSet.new(stage_team_params)
            if match_set.save
              render json: {status: 'SUCCESS', message:'Saved match set', data:match_set},status: :ok
            else
              render json: {status: 'ERROR', message:'Match set not saved', data:match_set.errors},status: :unprocessable_entity
            end
          else
            render json: {status: 'ERROR', message:'Match set not saved', data:{"match_id": ["must exist"]}},status: :not_found
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
      end

      def destroy
        if admin_signed_in?
          if MatchSet.exists?(params[:id])
            match_set = MatchSet.find(params[:id])
            if match_set.destroy
              render json: {status: 'SUCCESS', message:'Deleted match set', data:match_set},status: :ok
            else
              render json: {status: 'ERROR', message:'Match set not deleted', data:match_set.errors}, status: :unprocessable_entity
            end
          else
            render json: {status: 'ERROR', message:'Match set not deleted', data:{"id": ["must exist"]}},status: :not_found
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
      end

      def update
        if admin_signed_in?
          if MatchSet.exists?(params[:id])
            match_set = MatchSet.find(params[:id])
            if match_set.update(match_set_params)
              render json: {status: 'SUCCESS', message:'Updated match set', data:match_set},status: :ok
            else
              render json: {status: 'ERROR', message:'Match set not updated', data:match_set.errors},status: :unprocessable_entity
            end
          else
            render json: {status: 'ERROR', message:'Match set not updated', data:{"id": ["must exist"]}},status: :not_found
          end
        else
          render json: {status: 'Unauthorized', message:'Please sign in as administrator', data:401},status => 401
        end
      end


      private
        def match_set_params
          params.permit(:match_id, :set_number, :result)
        end
      end
  end
end
