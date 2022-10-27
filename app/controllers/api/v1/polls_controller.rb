# frozen_string_literal: true

module Api
  module V1
    # Polls management
    class PollsController < ApplicationController
      before_action :authenticate_user!

      def create
        place = Place.find(polls_params[:place_id])
        meal = Meal.find(polls_params[:meal_id])

        poll = Poll.new(user: current_user, place:, meal:)

        if poll.save
          render json: PollSerializer.new(poll)
        else
          render json: poll.errors, status: :unprocessable_entity
        end
      end

      private

      def polls_params
        params.required(:polls).permit(:place_id, :meal_id)
      end
    end
  end
end
