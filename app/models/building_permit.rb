class BuildingPermit < ApplicationRecord
  belongs_to :permit_type
  geocoded_by :full_street_address
  after_validation :geocode

  validates_presence_of :date_issued, :permit_number, :address,
                        :valuation, :fee, :owner_name, :contractor_name

  def full_street_address
    "#{address}, Denver Colorado"
  end

  def self.search_results(search, distance = 1)
    near("#{search}", distance)
  end

  def self.construction_value
    self.search_results.sum(:valuation)
  end
end
