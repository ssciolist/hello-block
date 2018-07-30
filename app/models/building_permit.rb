class BuildingPermit < ApplicationRecord
  belongs_to :permit_type
  geocoded_by :full_street_address
  after_validation :geocode

  validates_presence_of :date_issued, :permit_number, :address,
                        :valuation, :owner_name, :contractor_name
  validates :permit_number, uniqueness: true

  def full_street_address
    "#{address}, Denver Colorado"
  end

  def self.search_result(days, address, distance)
    includes(:permit_type)
    .where(date_issued: (DateTime.now - days.to_i)..(DateTime.now))
    .near(address, distance)
  end

  def self.aggregate_by_year(year, permit_class)
    includes(:permit_type)
    .where("permit_number LIKE '#{year}-#{permit_class}%'")
    .select('SUM(valuation) AS total')
  end
end
