# frozen_string_literal: true

module Api
  module V1
    # Places management
    class PlacesController < ApplicationController
      before_action :authenticate_user!

      def create
        meal = Meal.find(places_params[:meal_id])
        place = Place.new(user: current_user, name: places_params[:name], address: places_params[:address], meal:)

        if place.save
          render json: PlaceSerializer.new(place)
        else
          render json: place.errors, status: :unprocessable_entity
        end
      end

      def show
        place = Place.find(params[:id])

        render json: PlaceSerializer.new(place)
      end

      def destroy
        place = Place.find(params[:id])
        authorize! :write, place

        place.destroy

        render json: PlaceSerializer.new(place)
      rescue CanCan::AccessDenied => e
        render json: e.message, status: :unprocessable_entity
      end

      private

      def places_params
        params.required(:places).permit(:name, :address, :meal_id)
      end
    end
  end
end
