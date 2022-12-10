module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Loaded users', data:users},status: :ok
      end

      def show
        if User.exists?(params[:id])
          user = User.find(params[:id])
          render json: {status: 'SUCCESS', message:'Loaded user', data:user},status: :ok
        else
          render json: {status: 'ERROR', message:'User not found', data:user},status: :not_found
        end
      end

      def create
        user = User.new(user_params)
          if user.save
            render json: {status: 'SUCCESS', message:'Saved user', data:user},status: :ok
          else
            render json: {status: 'ERROR', message:'User not saved', data:user.errors},status: :unprocessable_entity
          end
      end

      private
        def user_params
          params.permit(:username, :password, :is_admin)
        end

    end
  end
end
