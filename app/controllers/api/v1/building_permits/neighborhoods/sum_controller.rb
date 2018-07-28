require 'rgeo/geo_json'

class Api::V1::BuildingPermits::Neighborhoods::SumController < ApplicationController
  def show
    # require 'pry'; binding.pry
    # nbhd_service = NeighborhoodService.new(permit_class, years_array)
    # render body: nbhd_service.summarize.to_json.delete("\\")[23..-4]
    var = Neighborhood.summarize_valuation(2018)
    array = []

    var.each do |x|
      feature = RGeo::GeoJSON::Feature.new(x.geom, x.id, {name: x.name, total: x.sum})
      array << feature
    end

    collection = RGeo::GeoJSON::FeatureCollection.new(array)

    render json: RGeo::GeoJSON.encode(collection)
  end

  private

  def years_array
    params[:years].split(',')
  end

  def permit_class
    params[:class]
  end
end
