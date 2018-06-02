require 'rails_helper'

describe 'As a logged in user' do
  describe 'when I visit my account page' do
    context 'with saved searches' do
      it 'I can delete the search' do
        user = create(:user)

        visit root_path
        click_on 'Log in'

        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password

        within('.new_user') do
          click_on 'Log in'
        end

        saved_search = create(:saved_search, user: user)
        visit user_path(user)

        expect(page).to have_link('Delete this search')
        click_on 'Delete this search'

        expect(page).to have_content("You haven't saved any searches")
      end
    end
  end
end
