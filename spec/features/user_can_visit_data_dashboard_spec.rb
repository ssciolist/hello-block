require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit the homepage' do
    describe "and I click on 'maps and more'" do
      describe "I see a page with a map"
        it 'shows me a map' do
          visit '/'

          click_on 'maps and more'
          expect(current_path).to eq('/data-dashboard')

          expect(page).to have_css('#neighborhood-map-container')
        end
    end
  end
end
