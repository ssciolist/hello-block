class Neighborhood < ApplicationRecord
  validates :name, :geom, presence: true

  def self.summarize_valuation(years)
    select('neighborhoods.name, SUM(building_permits.valuation) AS sum')
    .joins("INNER JOIN building_permits ON ST_Intersects(neighborhoods.geom, building_permits.geom)")
    .where("building_permits.permit_number LIKE '?%'", years)
    .group('neighborhoods.name')
  end
end
