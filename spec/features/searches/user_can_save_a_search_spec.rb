require 'rails_helper'

describe "As a visitor" do
  describe 'when I make a search' do
    it 'I should not see an option to save my search' do
      type = PermitType.create(name: 'Single family, detached', p_type: "003")
      permit = create_list(:building_permit, 4, permit_type: type)

      visit '/'

      address = '2035 N JASMINE ST, Denver Colorado'
      fill_in 'search', with: address
      click_on 'Search'

      expect(page).to_not have_button('Save this search')
    end
  end
end

describe "As a logged in user" do
  describe 'when I make a search' do
    describe 'and I click save this search' do
      it 'should create a link to this search on my profile page' do
        user = create(:user)

        visit root_path
        click_on 'Log in'

        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password

        within('.new_user') do
          click_on 'Log in'
        end

        type = PermitType.create(name: 'Single family, detached', p_type: "003")
        permit = create_list(:building_permit, 4, permit_type: type)

        visit '/'

        address = '2035 N JASMINE ST, Denver Colorado'
        fill_in 'search', with: address
        click_on 'Search'

        expect(page).to have_button('Save this search')
        click_on 'Save this search'

        expect(current_path).to eq(searches_path)
        expect(page).to have_content('Added to your saved searches.')

        visit root_path
        click_on 'My account'

        expect(page).to have_content('Permits within 1 mile of 2035 N JASMINE ST, Denver Colorado within the last 30 days')
        expect(page).to have_link('Results')
      end
    end
  end
end
