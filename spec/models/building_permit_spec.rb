require 'rails_helper'

RSpec.describe BuildingPermit, type: :model do
  context 'validations' do
    it { should validate_presence_of :date_issued }
    it { should validate_presence_of :permit_number }
    it { should validate_presence_of :address }
    it { should validate_presence_of :valuation }
    it { should validate_presence_of :fee }
    it { should validate_presence_of :owner_name }
    it { should validate_presence_of :contractor_name }
  end

  context 'relationships' do
    it { should belong_to :permit_type}
  end

  context 'class methods' do
    context '.search_results' do
      it 'returns a collections of building permits' do
        permit = PermitType.create(name: "New home", p_type: "003")
        BuildingPermit.create(date_issued: "2015-04-06 11:38:17", permit_number: "24", address: "123 street", valuation: 3780, fee: 4, owner_name: "JASMINE", contractor_name: "besine", permit_type: permit, latitude: 39.74863, longitude: -104.91841)
        BuildingPermit.create(date_issued: "2015-04-06 11:38:17", permit_number: "324", address: "3123 street", valuation: 33780, fee: 34, owner_name: "JASMINE", contractor_name: "besine", permit_type: permit, latitude: 39.7455399339223, longitude: -104.92825913894)
        near = BuildingPermit.near('2035 N JASMINE ST, Denver Colorado')
        search_results = BuildingPermit.search_results('2035 N JASMINE ST, Denver Colorado')

        expect(near.length).to eq(2)
        expect(search_results.length).to eq(2)
      end
    end
  end
end
