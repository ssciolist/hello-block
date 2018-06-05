class BuildingPermit < ApplicationRecord
  belongs_to :permit_type
  geocoded_by :full_street_address
  after_validation :geocode

  validates_presence_of :date_issued, :permit_number, :address,
                        :valuation, :owner_name, :contractor_name

  def full_street_address
    "#{address}, Denver Colorado"
  end

  def self.search_result(days, address, distance)
    includes(:permit_type)
    .where(date_issued: (DateTime.now - days.to_i)..(DateTime.now))
    .near(address, distance)
  end

end
