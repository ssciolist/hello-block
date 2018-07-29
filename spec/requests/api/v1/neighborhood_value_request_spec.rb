require 'rails_helper'

describe 'Building Permit API summarize' do
  it 'can group permits by neighborhood and return geojson with value sum' do

    type = PermitType.create(name: 'Single family, detached', p_type: "003")
    create_list(:building_permit, 5, permit_type: type)

    get '/api/v1/building_permits/neighborhoods/summarize?class=all&years=2015,2016,2017,2018'

    search_result = JSON.parse(response.body)

    expect(response).to be_successful

    # Check for no missing data
    expect(search_result['features'].count).to eq(78)
    search_result['features'].each {|feature| feature.properties.has_key?('id')}
    search_result['features'].each {|feature| feature.properties.has_key?('name')}
    search_result['features'].each {|feature| feature.properties.has_key?('total')}

    #Check that one neighborhood, S. Park Hill, has valuation greater than 0
    search_result['features'].any? {|feature| feature.properties['total'] > 0}
  end

  it 'can group permits by neighborhood and year and return geojson with value sum' do
    skip
    type = PermitType.create(name: 'Single family, detached', p_type: "003")
    create(:building_permit, permit_number: "2018-COMMCON-1", valuation: 90, permit_type: type)
    create(:building_permit, permit_number: "2017-COMMCON-2", valuation: 45, permit_type: type)

    get '/api/v1/building_permits/neighborhoods/summarize?class=all&years=2017'

    search_result = JSON.parse(response.body)

    expect(response).to be_successful

    # Check for no missing data
    expect(search_result['features'].count).to eq(78)
    search_result['features'].each {|feature| feature.properties.has_key?('id')}
    search_result['features'].each {|feature| feature.properties.has_key?('name')}
    search_result['features'].each {|feature| feature.properties.has_key?('total')}

    #Check that one neighborhood, S. Park Hill, has valuation equal to 2017
    search_result['features'].any? {|feature| feature.properties['total'] == 45}
  end

  it 'can group residential permits by year and return valuation sum' do
    skip
    type = PermitType.create(name: 'Single family, detached', p_type: "003")
    create(:building_permit, permit_number: "2018-COMMCON-1", valuation: 45, permit_type: type)
    create(:building_permit, permit_number: "2018-COMMCON-2", valuation: 45, permit_type: type)
    create(:building_permit, permit_number: "2018-COMMCON-3", valuation: 45, permit_type: type)
    create(:building_permit, permit_number: "2018-COMMCON-4", valuation: 45, permit_type: type)
    create(:building_permit, permit_number: "2017-RESCON-5", valuation: 425, permit_type: type)

    get '/api/v1/building_permits/summarize?class=RESCON&years=2015,2016,2017,2018&group=years'

    search_result = JSON.parse(response.body)

    expect(response).to be_successful

    # Check for no missing data
    expect(search_result['features'].count).to eq(78)
    search_result['features'].each {|feature| feature.properties.has_key?('id')}
    search_result['features'].each {|feature| feature.properties.has_key?('name')}
    search_result['features'].each {|feature| feature.properties.has_key?('total')}

    #Check that one neighborhood, S. Park Hill, has valuation equal to RESCON permit
    search_result['features'].any? {|feature| feature.properties['total'] == 425}
  end

  it 'can group commercial permits by year and return valuation sum' do
    skip
    type = PermitType.create(name: 'Single family, detached', p_type: "003")
    create(:building_permit, permit_number: "2018-COMMCON-1", valuation: 45, permit_type: type)
    create(:building_permit, permit_number: "2018-COMMCON-2", valuation: 45, permit_type: type)
    create(:building_permit, permit_number: "2017-RESCON-5", valuation: 425, permit_type: type)

    get '/api/v1/building_permits/summarize?class=COMMCON&years=2015,2016,2017,2018&group=years'

    search_result = JSON.parse(response.body)

    expect(response).to be_successful

    # Check for no missing data
    expect(search_result['features'].count).to eq(78)
    search_result['features'].each {|feature| feature.properties.has_key?('id')}
    search_result['features'].each {|feature| feature.properties.has_key?('name')}
    search_result['features'].each {|feature| feature.properties.has_key?('total')}

    #Check that one neighborhood, S. Park Hill, has valuation equal to 2 COMMCON permits
    search_result['features'].any? {|feature| feature.properties['total'] == 425}
  end
end
