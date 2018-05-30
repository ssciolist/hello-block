class BuildingPermitService
  def initialize(days, distance, address)
    @days = days
    @distance = distance
    @address = address
  end

  private

  def conn
    Faraday.get("http://localhost:3000/api/v1/building_permits/find?days=#{@days}&distance=#{@distance}&address=#{@address}")
  end

end
