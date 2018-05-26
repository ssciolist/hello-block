require 'rails_helper'

describe 'As a visitor,' do
  describe 'when I visit the homepage' do
    describe 'and enter a Denver address in the search bar,' do
      it 'shows me a figure and permit results within one mile' do
        permit = PermitType.create(name: "New home", p_type: "003")
        BuildingPermit.create(date_issued: "2018-05-22 11:38:17", permit_number: "24", address: "2035 North Jasmine Street", valuation: 770689, fee: 4, owner_name: "JASMINE", contractor_name: "besine", permit_type: permit, latitude: 39.748276, longitude: -104.918953)
        BuildingPermit.create(date_issued: "2018-05-22 11:38:17", permit_number: "324", address: "2060 North Jasmine Street", valuation: 1, fee: 34, owner_name: "JASMINE", contractor_name: "besine", permit_type: permit, latitude: 39.7455399339223, longitude: -104.92825913894)

        visit '/'

        fill_in 'search', with: '2035 N JASMINE ST, Denver Colorado'
        click_on 'Search'

        expect(current_path).to eq('/searches')
        expect(page).to have_content('Approximately $770,690.00 in construction was planned within 1 mile')
        expect(page).to have_content('in the past 30 days')
        expect(page).to have_css('.building_permit', count: 2)
      end
    end
  end

  describe 'when I am on a search result page' do
    it 'gives me options to change my search' do
      type = PermitType.create(name: 'Single family, detached', p_type: "003")
      permit = create_list(:building_permit, 4, permit_type: type)

      visit '/'

      address = '2035 N JASMINE ST, Denver Colorado'
      fill_in 'search', with: address
      click_on 'Search'

      expect(page).to have_content('Refine your search')
      expect(page).to have_field('search', placeholder: address)
      expect(page).to have_field('distance')
      expect(page).to have_field('days')
      expect(page).to have_field('Single family, detached', checked: false)
    end

    it 'lets me do another search' do
      single_type = PermitType.create(name: 'Single family, detached', p_type: "003")
      commercial_type = PermitType.create(name: 'Two family dwellings', p_type: "008")
      create(:building_permit, permit_type: single_type, date_issued: Time.now)
      create(:building_permit, permit_type: single_type, date_issued: Time.now)
      create(:building_permit, permit_type: commercial_type, address: '1463 Jasmine Street', date_issued:(Time.now - 900000))
      create(:building_permit, permit_type: commercial_type, address: '1463 Jasmine Street', date_issued:(Time.now - 900000))
      commercial_permit = create(:building_permit, permit_type: commercial_type)

      visit '/'

      address = '2035 N JASMINE ST, Denver Colorado'
      fill_in 'search', with: address
      click_on 'Search'
      expect(page).to have_css('.building_permit', count: 5)

      fill_in 'search', with: address
      fill_in 'distance', with: 0.5
      fill_in 'days', with: 2
      check 'Single family, detached'

      click_on 'Search again'

      expect(page).to have_css('.building_permit', count: 2)
      expect(page).to_not have_content(commercial_permit.permit_type.name)
      expect(page).to_not have_content('1463 Jasmine Street')

    end
  end
end
