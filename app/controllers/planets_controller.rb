class PlanetsController < ApplicationController
  before_action :set_planet, only: [ :show, :update, :destroy ]
rescue_from ActiveRecord::RecordInvalid, with: :invalid
rescue_from ActiveRecord::RecordNotFound, with: :not_found


  # GET /planets
  def index
    planets = Planet.all

    render json: planets, status: :ok
  end

  def show
    # planet = Planet.find(params[:id])
    render json: @planet, status: :ok
  end

  def create
    planet = Planet.create!(planet_params)
    render json: planet, status: :created
  end

  def update
    # planet = Planet.find(params[:id])
    @planet.update!(planet_params)
    render json: @planet, status: :ok
  end

  def destroy
    # planet = Planet.find(params[:id])
    @planet.destroy
    head :no_content
  end
  private

  def set_planet
    @planet = Planet.find(params[:id])
  end

  def planet_params
    params.permit(:name, :distance_from_earth, :nearest_star, :image)
  end
  def not_found
    render json: {"error": "Planet not found"}
  end

  def invalid
    render json: {"errors": ["validation errors"]}
  end
end
