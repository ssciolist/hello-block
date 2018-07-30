require 'rgeo/geo_json'

class NeighborhoodPresenter
  def initialize(permit_class, year)
    @pc = permit_class
    @year = year
  end

  def geojson_summary
    RGeo::GeoJSON.encode(geojson_feature_collection)
  end

  def geojson_feature_collection
    hoods_w_totals = Neighborhood.summarize_valuation(@year)
    feature_array = []

    hoods_w_totals.each do |nbhd|
      feature = RGeo::GeoJSON::Feature.new(nbhd.geom, nbhd.id, {name: nbhd.name, total: nbhd.sum})
      feature_array << feature
    end

    RGeo::GeoJSON::FeatureCollection.new(feature_array)
  end
end
