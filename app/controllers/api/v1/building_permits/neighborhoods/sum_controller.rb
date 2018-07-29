class Api::V1::BuildingPermits::Neighborhoods::SumController < ApplicationController
  caches_action :show, :cache_path => Proc.new {|c| c.request.url }

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

  def person_params
    params.permit(:class, :years)
  end
end
