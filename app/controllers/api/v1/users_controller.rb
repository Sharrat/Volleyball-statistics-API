module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Loaded users', data:users},status: :ok
      end

#SHOW SINGULAR
      def show
        if User.exists?(params[:id])
          user = User.find(params[:id])
          render json: {status: 'SUCCESS', message:'Loaded user',
            data:{"id":user.id, "username":user.username, "is_admin":user.is_admin, "created_at":user.created_at, "updated_at":user.updated_at}},status: :ok
        else
          render json: {status: 'ERROR', message:'User not found', data:user},status: :not_found
        end
      end

#CREATE
      def create
        user = User.new(user_params)
          if user.save
            render json: {status: 'SUCCESS', message:'Saved user',
              data:{"id":user.id, "username":user.username, "is_admin":user.is_admin, "created_at":user.created_at, "updated_at":user.updated_at}},status: :ok
          else
            render json: {status: 'ERROR', message:'User not saved', data:user.errors},status: :unprocessable_entity
          end
      end

#DESTROY
      def destroy
        if User.exists?(params[:id])
          user = User.find(params[:id])
          user.destroy
          render json: {status: 'SUCCESS', message:'Deleted user',
            data:{"id":user.id, "username":user.username, "is_admin":user.is_admin, "created_at":user.created_at, "updated_at":user.updated_at}},status: :ok
        else
          render json: {status: 'ERROR', message:'User not found', data:user.errors},status: :unprocessable_entity
        end
      end

#UPDATE
      def update
        user = User.find(params[:id])
        if user.update(user_params)
          render json: {status: 'SUCCESS', message:'Updated user',
            data:{"id":user.id, "username":user.username, "is_admin":user.is_admin, "created_at":user.created_at, "updated_at":user.updated_at}},status: :ok
        else
          render json: {status: 'ERROR', message:'User not updated', data:user.errors},status: :unprocessable_entity
        end
      end

      private
        def user_params
          params.permit(:username, :password, :is_admin)
        end

    end
  end
end
