require 'rails_helper'

describe 'As a user' do
  describe 'when I visit the homepage' do
    describe 'and I click on log in,' do
      it 'I can sign in with an email and password' do
        user = create(:user)

        visit root_path
        click_on 'Log in'

        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password

        within('.new_user') do
          click_on 'Log in'
        end

        expect(current_path).to eq(root_path)
        expect(page).to have_content('Signed in successfully.')
        expect(page).to_not have_content('Log in')
        expect(page).to have_content('Log out')
      end

      it 'I can sign in using Google' do
        stub_omniauth
        visit root_path

        click_on 'Log in'
        click_on 'Sign in with Google'


        expect(page).to have_content('Successfully authenticated from Google account.')
        expect(page).to_not have_content('Log in')
        expect(page).to have_content('Log out')
      end
    end

    describe 'and I\'m already logged in' do
      describe 'I can click log out,' do
        it 'and I will be logged out' do
          user = create(:user)

          visit root_path
          click_on 'Log in'

          fill_in 'user[email]', with: user.email
          fill_in 'user[password]', with: user.password

          within('.new_user') do
            click_on 'Log in'
          end

          expect(current_path).to eq(root_path)

          click_on 'Log out'

          expect(page).to have_content('Signed out successfully.')
          expect(page).to have_content('Log in')
        end
      end
    end
  end
end
