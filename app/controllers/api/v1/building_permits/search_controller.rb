class Api::V1::BuildingPermits::SearchController < ApplicationController
  def show
    render json: BuildingPermit.all
  end
end
