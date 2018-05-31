require 'rails_helper'


describe 'As a logged in user' do
  describe 'when I visit my account page' do
    context 'with saved searches' do
      it 'I can sign up for a weekly email' do
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
        click_on 'Sign up for weekly email'
        expect(page).to have_content("we're excited to be sending you weekly updates about your search at 2035 N JASMINE ST")

        saved_search = SavedSearch.last

        mail = SearchMailer.weekly_mail(saved_search)
require 'pry'; binding.pry
        expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)

        expect(mail.to).to eq([user.email])
        expect(mail.subject).to eq("This week's building permits from #{saved_search.address}")
        expect(mail.from).to eq(['no-reply@hello-block.herokuapp.com'])

        text_body = File.read('spec/fixtures/search_mailer/activate.txt')
        html_body = File.read('spec/fixtures/search_mailer/activate.html')

        expect(mail.text_part.body).to eq(text_body)
        expect(mail.html_part.body).to eq(html_body)
      end

      it 'I can get a test email right away' do
      end
    end
  end
end
