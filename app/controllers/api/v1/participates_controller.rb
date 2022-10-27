# frozen_string_literal: true

module Api
  module V1
    # Participates management
    class ParticipatesController < ApplicationController
      before_action :authenticate_user!

      def create
        meal = Meal.find(participates_params[:meal_id])
        participate = Participate.new(meal:, user: current_user)

        if participate.save
          render json: ParticipateSerializer.new(participate)
        else
          render json: participate.errors, status: :unprocessable_entity
        end
      end

      def destroy
        participate = Participate.find(params[:id])

        participate.destroy

        render json: ParticipateSerializer.new(participate)
      end

      private

      def participates_params
        params.required(:participates).permit(:meal_id)
      end
    end
  end
end
