require 'rails_helper'

describe 'As a visitor,' do
  describe 'when I visit the homepage' do
    describe 'and enter a Denver address in the search bar,' do
      it 'shows me a figure and permit results within one mile' do
        visit '/'

        fill_in 'search', with: '2035 N JASMINE ST, Denver Colorado'
        click_on 'Search'

        expect(current_path).to eq('/search')
        expect(page).to have_content('Approximately $770,690 in construction was planned within 1 mile')
        expect(page).to have_css('.building_permit', count: 2)
      end
    end
  end
end
