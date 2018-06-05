class BuildingPermitSearchPresenter
  attr_reader :days, :distance, :address
  def initialize(days, search, distance)
    @days = days
    @distance = distance
    @address = search
  end

  def search_results
    @results ||= BuildingPermit.search_result(@days, @address, @distance)
  end

  def value
    search_results.sum(:valuation)
  end
end
