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

  def annual_percentage_change
    hash_2015 = hash_nbhds(Neighborhood.summarize_valuation([@year[0]]))

    hash_2016 = hash_nbhds(Neighborhood.summarize_valuation([@year[1]]))

    hash_2017 = hash_nbhds(Neighborhood.summarize_valuation([@year[2]]))

    hash_2018 = hash_nbhds(Neighborhood.summarize_valuation([@year[3]]))

    percent_change_2016 = hash_2015.merge(hash_2016) do |key, old_v, new_v|
      (new_v - old_v) / old_v.to_f
    end

    percent_change_2017 = hash_2016.merge(hash_2017) do |key, old_v, new_v|
      (new_v - old_v) / old_v.to_f
    end

    average_percent_change = percent_change_2017.merge(percent_change_2016) do |key, old_v, new_v|
      (new_v + old_v) / 2.0
    end

    average_percent_change.sort_by {|key, value| value}.reverse.to_h
  

  end

  def hash_nbhds(json_array)
    json_array.reduce(Hash.new(0)) do |hash, neighborhood|
      key = neighborhood["name"]
      hash[key] += neighborhood["sum"]
      hash
    end
  end
end
