# frozen_string_literal: true

module Api
  module V1
    # Meals management
    class MealsController < ApplicationController
      before_action :authenticate_user!

      def create
        meal = Meal.new(user: current_user, name: meals_params[:name], day_at: meals_params[:day_at])

        if meal.save
          render json: MealSerializer.new(meal)
        else
          render json: meal.errors, status: :unprocessable_entity
        end
      end

      def show
        meal = Meal.find(params[:id])

        render json: MealSerializer.new(meal)
      end

      def update
        meal = Meal.find(params[:id])
        authorize! :write, meal

        if meal.update(meals_params)
          render json: MealSerializer.new(meal)
        else
          render json: meal.errors, status: :unprocessable_entity
        end
      end

      def destroy
        meal = Meal.find(params[:id])
        authorize! :write, meal

        meal.destroy

        render json: MealSerializer.new(meal)
      end

      private

      def meals_params
        params.required(:meals).permit(:name, :day_at)
      end
    end
  end
end
