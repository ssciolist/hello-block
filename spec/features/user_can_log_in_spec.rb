
require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit the homepage' do
    describe 'and I click on sign up' do
      it 'creates a new account' do
        visit root_path
        click_on "Sign up"
        fill_in "user[username]", with: "Paul"
        fill_in "user[password]", with: "Karolyi"
        fill_in "user[confirm_password]", with: "Karolyi"
        click_on "Sign Up"

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("Account created successfully")
        expect(page).to have_content("Logged in as Paul")
        expect(page).to_not have_content("Login")
        expect(page).to have_content("Logout")
      end

      it 'passwords must match' do
        visit root_path
        click_on "Create Account"
        fill_in "user[username]", with: "Batman"
        fill_in "user[password]", with: "Robin"
        fill_in "user[confirm_password]", with: "Williams"
        click_on "Sign Up"

        expect(current_path).to eq(new_user_path)
        expect(page).to have_content("Passwords do not match")
        expect(page).to have_content("Login")
        expect(page).to_not have_content("Logout")
      end
    end
  end
end
