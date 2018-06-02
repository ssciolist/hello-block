require 'rails_helper'

describe 'Building Permit Service' do
  subject { BuildingPermitService.new(16, 0.5, "16227 E 54th Ave, Denver, CO 80239") }

  it 'exists' do
    expect(subject).to be_a BuildingPermitService
  end

  context 'instance methods' do
    context '#permit_search' do
      it 'returns an array of hashes with building permit data' do
        stub_request(:get, "https://hello-block.herokuapp.com/api/v1/building_permits/find?address=16227%20E%2054th%20Ave,%20Denver,%20CO%2080239&days=16&distance=0.5").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v0.12.2'
           }).
         to_return(status: 200, body: File.read("./spec/fixtures/building_permit_service/bps_16227_E_54th_Ave.json"), headers: {})

        raw_permits = subject.permit_search
        raw_permit = subject.permit_search.first

        expect(raw_permits.count).to eq(4)
        expect(raw_permit).to have_key(:permit_number)
        expect(raw_permit).to have_key(:address)
        expect(raw_permit).to have_key(:valuation)
        expect(raw_permit).to have_key(:date_issued)
        expect(raw_permit).to have_key(:owner_name)
        expect(raw_permit).to have_key(:contractor_name)
        expect(raw_permit).to have_key(:permit_type)
        expect(raw_permit).to have_key(:building_class)
      end
    end
  end
end
