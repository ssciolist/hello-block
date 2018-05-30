require 'rails_helper'

describe 'Building Permit API index' do
  it 'can find permits by search parameters' do
    type = PermitType.create(name: 'Single family, detached', p_type: "003")
    building_permits = create_list(:building_permit, 4, permit_type: type)

    get '/api/v1/building_permits/find?days=30&distance=1&address=2035+N+JASMINE+ST%2C+Denver+Colorado'

    search_result = JSON.parse(response.body)

    expect(response).to be_success
    expect(search_result.count).to eq(4)
    expect(search_result[0]['date_issued']).to eq(building_permits.first.date_issued)
    expect(search_result[0]['address']).to eq(building_permits.first.address)
    expect(search_result[0]['building_class']).to eq(building_permits.first.building_class)
    expect(search_result[0]['valuation']).to eq(building_permits.first.valuation)
    expect(search_result[0]['owner_name']).to eq(building_permits.first.owner_name)
    expect(search_result[0]['contractor_name']).to eq(building_permits.first.contractor_name)
    expect(search_result[0]['permit_type_id']).to eq(building_permits.first.permit_type)
  end
end
