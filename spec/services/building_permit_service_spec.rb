require 'rails_helper'

describe 'Building Permit Service' do
  subject { BuildingPermitService.new(30, 1, "2035 N Jasmine Street, Denver Colorado") }

  it 'exists' do
    expect(subject).to be_a BuildingPermitService
  end

  context 'instance methods' do
    context '#permit_search' do
      it 'returns an array of hashes with building permit data' do
        raw_permits = subject.permit_search
        raw_permit = subject.permit_search.first

        expect(raw_permits.count).to eq(46)
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
