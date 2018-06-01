class BuildingPermitService
  def initialize(days, distance, address)
    @days = days
    @distance = distance
    @address = address
  end

  def permit_search
    JSON.parse(conn.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.get("http://localhost:3000/api/v1/building_permits/find?days=#{@days}&distance=#{@distance}&address=#{@address}")
  end

end
