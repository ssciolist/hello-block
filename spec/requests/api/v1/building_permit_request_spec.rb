require 'rails_helper'

describe 'Building Permit API index' do
  it 'can find permits by search parameters' do
    type = PermitType.create(name: 'Single family, detached', p_type: "003")
    create_list(:building_permit, 4, permit_type: type)

    get '/api/v1/building_permits/find?days=1&distance=30&address=2035+N+JASMINE+ST%2C+Denver+Colorado'

    search_result = JSON.parse(response.body)

    expect(response).to be_success
    expect(search_result.count).to eq(4)
    expect(search_result[0]['Date Issued']).to eq(4)
    expect(search_result[0]['Address']).to eq(4)
    expect(search_result[0]['Building Class']).to eq(4)
    expect(search_result[0]['Estimated Value']).to eq(4)
    expect(search_result[0]['Owner Name']).to eq(4)
    expect(search_result[0]['Contractor Name']).to eq(4)
    expect(search_result[0]['Permit Type']).to eq(4)
  end
end
