
require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit the homepage' do
    describe 'and I click on sign up' do
      it 'creates a new account' do
        visit root_path
        click_on "Sign up"

        fill_in "user[email]", with: "PaulKarolyi@gmail.com"
        fill_in "user[password]", with: "Karolyi"
        fill_in "user[password_confirmation]", with: "Karolyi"
        click_on "Sign up"

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("Welcome! You have signed up successfully.")
        expect(page).to_not have_content("Login")
        expect(page).to have_content("Logout")
      end
    end
  end
end

describe 'As a user' do
  describe 'when I visit the homepage' do
    describe 'and I click on log in,' do
      it 'I can sign in' do
        user = create(:user)

        visit root_path
        click_on "Log in"

        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password

        within('.new_user') do
          click_on "Log in"
        end

        expect(current_path).to eq(root_path)
        expect(page).to have_content("Signed in successfully.")
        expect(page).to_not have_content("Login")
        expect(page).to have_content("Log out")
      end
    end
  end
end
