class Api::V1::BuildingPermits::Neighborhoods::SumController < ApplicationController
  def show
    nbhd_service = NeighborhoodService.new(permit_class, years_array)

    render body: nbhd_service.summarize.to_json.delete("\\")[23..-4]
  end

  private

  def years_array
    params[:years].split(',')
  end

  def permit_class
    params[:class]
  end
end
