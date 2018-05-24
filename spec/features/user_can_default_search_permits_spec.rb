require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit the homepage' do
    describe 'and enter a Denver address in the search bar' do
      it 'shows me a figure and first 15 permit results' do
        visit '/'

        fill_in 'search-form', with: '2035 N JASMINE ST, Denver Colorado'

        expect(current_path).to eq('/search')
        expect(page).to have_content('Approximately $770,690 in construction was planned within 1 mile')
        expect(page).to have_css('.building_permit', count: 2)
      end
    end
  end
end
