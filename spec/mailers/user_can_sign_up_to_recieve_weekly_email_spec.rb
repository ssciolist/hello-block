require 'rails_helper'

RSpec.describe SearchMailer, type: :mailer do
  describe 'As a logged in user' do
    describe 'when I visit my account page' do
      context 'with saved searches' do

        it 'I can sign up for a weekly email' do
          user = create(:user)
          saved_search = create(:saved_search, user: user)
          visit user_path(user)

          click_on 'Sign up for weekly email'

          mail = SearchMailer.weekly_mail(saved_search)

          expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)

          # expect(mail.subject).to eq("????")
          expect(mail.to).to eq([user.email])
          # expect(mail.from).to eq([???])

          text_body = File.read('spec/fixtures/search_mailer/activate.txt')
          html_body = File.read('spec/fixtures/search_mailer/activate.html')

          expect(mail.text_part.body).to eq(text_body)
          expect(mail.html_part.body).to eq(html_body)
        end
      end
    end
  end
end
