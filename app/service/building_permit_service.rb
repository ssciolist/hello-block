class BuildingPermitService
  def initialize(days, distance, address)
    @days = days
    @distance = distance
    @address = address
  end

  def permit_search
    # require 'pry'; binding.pry
    JSON.parse(conn.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.get("https://hello-block.herokuapp.com/api/v1/building_permits/find?days=#{@days}&distance=#{@distance}&address=#{@address}")
  end

end
