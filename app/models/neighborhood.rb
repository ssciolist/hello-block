require 'rgeo/geo_json'
class Neighborhood < ApplicationRecord
  validates :name, :geom, presence: true

  def self.summarize_valuation(years)
    select('neighborhoods.name, neighborhoods.geom, SUM(building_permits.valuation) AS sum')
    .joins("INNER JOIN building_permits ON ST_Intersects(neighborhoods.geom, building_permits.geom)")
    .where("building_permits.permit_number ILIKE ANY ( array[?] )", years)
    .group('neighborhoods.name, neighborhoods.geom')
  end
end
