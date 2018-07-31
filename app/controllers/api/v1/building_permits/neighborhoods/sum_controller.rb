class Api::V1::BuildingPermits::Neighborhoods::SumController < ApplicationController
  caches_action :show, expires_in: 100.hour, :cache_path => Proc.new {|c| c.request.url }
  caches_action :percent_change, expires_in: 100.hour, :cache_path => Proc.new {|c| c.request.url }

  def show
    render json: NeighborhoodPresenter.new(permit_class, years).geojson_summary
  end

  def percent_change
    render json: NeighborhoodPresenter.new(permit_class, years).annual_percentage_change
  end

  private

  def years
    array = params[:years].split(',').map {|year| "#{year}%" }
  end

  def permit_class
    params[:class]
  end
end
