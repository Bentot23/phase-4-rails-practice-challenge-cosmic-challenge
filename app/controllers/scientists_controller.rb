class ScientistsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found
rescue_from ActiveRecord::RecordInvalid, with: :invalid

    before_action :one_scientist, only: [:show, :update, :destroy]


    def index
        render json: Scientist.all, status: :ok
    end

    def show
        # scientist = Scientist.find(params[:id])
        render json: @scientist, serializer: ScientistPlanetSerializer, status: :ok
    end

    def create
        scientist = Scientist.create!(scientist_params)
        render json: scientist, status: :created
    end

    def update
        # scientist = Scientist.find(params[:id])
        @scientist.update!(scientist_params_update)
        render json: @scientist, status: :accepted
    end

    def destroy
        # scientist = Scientist.find(params[:id])
        @scientist.destroy
        head :no_content
    end

    private

    def one_scientist
        @scientist = Scientist.find(params[:id])
    end

    def scientist_params
        params.permit(:name, :field_of_study, :avatar)
    end

    def scientist_params_update
        params.permit(:name, :field_of_study, :avatar)
    end

    def not_found
        render json: {"error": "Scientist not found"}
    end

    def invalid
        render json: {"errors": ["validation errors"]}
    end
end
