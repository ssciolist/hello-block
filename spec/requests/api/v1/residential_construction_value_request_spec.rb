require 'rails_helper'

describe 'Building Permit API index' do
  it 'can group residential permits by year' do
    type = PermitType.create(name: 'Single family, detached', p_type: "003")
    create(:building_permit, permit_number: "2018-RESCON-1", valuation: 300, permit_type: type)
    create(:building_permit, permit_number: "2018-RESCON-2", valuation: 300, permit_type: type)
    create(:building_permit, permit_number: "2018-RESCON-3", valuation: 300, permit_type: type)
    create(:building_permit, permit_number: "2018-RESCON-4", valuation: 300, permit_type: type)
    create(:building_permit, permit_number: "2017-RESCON-5", valuation: 100, permit_type: type)
    create(:building_permit, permit_number: "2017-RESCON-6", valuation: 100, permit_type: type)
    create(:building_permit, permit_number: "2017-RESCON-7", valuation: 100, permit_type: type)
    create(:building_permit, permit_number: "2017-RESCON-8", valuation: 100, permit_type: type)
    create(:building_permit, permit_number: "2016-RESCON-9", valuation: 50, permit_type: type)
    create(:building_permit, permit_number: "2016-RESCON-10", valuation: 50, permit_type: type)

    get '/api/v1/building_permits_values/find?class=RESCON&years=2015,2016,2017,2018&group=years'

    search_result = JSON.parse(response.body)

    expect(response).to be_successful
    expect(search_result[0]['date']).to eq(2018)
    expect(search_result[0]['total_valuation']).to eq(1200)
    expect(search_result[1]['date']).to eq(2017)
    expect(search_result[1]['total_valuation']).to eq(400)
    expect(search_result[1]['date']).to eq(2016)
    expect(search_result[1]['total_valuation']).to eq(100)
  end
end

describe 'Building Permit API index' do
  it 'can group commercial permits by year' do
    type = PermitType.create(name: 'Single family, detached', p_type: "003")
    create(:building_permit, permit_number: "2018-COMMCON-1", valuation: 45, permit_type: type)
    create(:building_permit, permit_number: "2018-COMMCON-2", valuation: 45, permit_type: type)
    create(:building_permit, permit_number: "2018-COMMCON-3", valuation: 45, permit_type: type)
    create(:building_permit, permit_number: "2018-COMMCON-4", valuation: 45, permit_type: type)
    create(:building_permit, permit_number: "2017-COMMCON-5", valuation: 425, permit_type: type)
    create(:building_permit, permit_number: "2017-COMMCON-6", valuation: 425, permit_type: type)
    create(:building_permit, permit_number: "2017-COMMCON-7", valuation: 425, permit_type: type)
    create(:building_permit, permit_number: "2017-COMMCON-8", valuation: 425, permit_type: type)
    create(:building_permit, permit_number: "2016-COMMCON-9", valuation: 8, permit_type: type)
    create(:building_permit, permit_number: "2016-COMMCON-10", valuation: 8, permit_type: type)

    get '/api/v1/building_permits_values/find?class=COMMCON&years=2015,2016,2017,2018&group=years'

    search_result = JSON.parse(response.body)

    expect(response).to be_successful
    expect(search_result[0]['date']).to eq(2018)
    expect(search_result[0]['total_valuation']).to eq(1800)
    expect(search_result[1]['date']).to eq(2017)
    expect(search_result[1]['total_valuation']).to eq(17000)
    expect(search_result[1]['date']).to eq(2016)
    expect(search_result[1]['total_valuation']).to eq(16)
  end
end



# BuildingPermit.where("permit_number LIKE '2018-RESCON%'").select('SUM(valuation) AS total').group("DATE_TRUNC('month', date_issued)")
