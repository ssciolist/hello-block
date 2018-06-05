require 'rails_helper'

describe 'As a visitor' do
  describe 'after I search an address' do
    describe 'I have the option to see it on a map' do
      it 'shows me a map' do
        permit = PermitType.create(name: "New home", p_type: "003")
        BuildingPermit.create(date_issued: "2018-05-22 11:38:17", permit_number: "24", address: "2035 North Jasmine Street", valuation: 770689, fee: 4, owner_name: "JASMINE", contractor_name: "besine", permit_type: permit, latitude: 39.748276, longitude: -104.918953)
        BuildingPermit.create(date_issued: "2018-05-22 11:38:17", permit_number: "324", address: "2060 North Jasmine Street", valuation: 1, fee: 34, owner_name: "JASMINE", contractor_name: "besine", permit_type: permit, latitude: 39.7455399339223, longitude: -104.92825913894)

        visit '/'

        fill_in 'search', with: '2035 N JASMINE ST, Denver Colorado'
        click_on 'Search'

        expect(page).to have_button('Search again')
        expect(page).to have_button('Show me a map instead')
        click_on 'Show me a map instead'

        expect(current_path).to eq('/maps')
        expect(page).to have_css('#map')
      end
    end
  end
end
