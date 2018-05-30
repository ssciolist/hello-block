class Api::V1::BuildingPermits::SearchController < ApplicationController
  def show
    render json: BuildingPermit.search_result(params[:days], params[:address], params[:distance])
  end
end
