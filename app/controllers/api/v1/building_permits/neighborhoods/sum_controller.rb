

class Api::V1::BuildingPermits::Neighborhoods::SumController < ApplicationController
  def show
    render json: NeighborhoodPresenter.new(permit_class, years).geojson_summary
  end

  private

  def years
    array = params[:years].split(',').map {|year| "#{year}%" }
  end

  def permit_class
    params[:class]
  end
end
