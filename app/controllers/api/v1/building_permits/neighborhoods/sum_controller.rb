class Api::V1::BuildingPermits::Neighborhoods::SumController < ApplicationController
  def show
    nbhd_service = NeighborhoodService.new("all", 2015)

    render body: nbhd_service.summarize.to_json.delete("\\")[23..-4]
  end

  private

  def years_array
    params[:years].split(',')
  end
end
