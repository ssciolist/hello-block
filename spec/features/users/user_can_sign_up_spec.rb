require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit the homepage' do
    describe 'and I click on sign up' do
      it 'I can create a new account' do
        visit root_path
        click_on 'Sign up'

        fill_in 'user[email]', with: 'PaulKarolyi@gmail.com'
        fill_in 'user[password]', with: 'Karolyi'
        fill_in 'user[password_confirmation]', with: 'Karolyi'

        within('.new_user') do
          click_on 'Sign up'
        end

        expect(current_path).to eq(root_path)
        expect(page).to have_content('Welcome! You have signed up successfully.')
        expect(page).to_not have_content('Log in')
        expect(page).to have_content('Log out')
      end
    end
  end
end
