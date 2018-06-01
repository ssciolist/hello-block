require 'rails_helper'

describe 'Building Permit API index' do
  it 'can find permits by search parameters' do
    type = PermitType.create(name: 'Single family, detached', p_type: "003")
    building_permits = create_list(:building_permit, 4, permit_type: type)

    get '/api/v1/building_permits/find?days=30&distance=1&address=2035+N+JASMINE+ST%2C+Denver+Colorado'

    search_result = JSON.parse(response.body)

    expect(response).to be_successful
    expect(search_result.count).to eq(4)
  end
end
