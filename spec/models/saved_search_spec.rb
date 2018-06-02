require 'rails_helper'

RSpec.describe SavedSearch, type: :model do
  describe 'validations' do
    it { should validate_presence_of :current_url }
  end

  describe 'instance methods' do
    let(:user) { create(:user) }
    subject { create(:saved_search, user: user)}

    context '#address' do
      it 'returns a string address' do
        expect(subject.address).to eq "2035 N JASMINE ST, Denver Colorado"
      end
    end

    context '#distance' do
      it 'returns a string distance' do
        expect(subject.distance).to eq "1"
      end
    end

    context '#days' do
      it 'returns a string days' do
        expect(subject.days).to eq "30"
      end
    end

    context '#weekly_email' do
      it 'defaults to false' do
        expect(subject.weekly_email).to eq('no')
      end
    end
  end
end
