require 'rails_helper'

RSpec.describe BuildingPermit, type: :model do
  context 'validations' do
    it { should validate_presence_of :date_issued }
    it { should validate_presence_of :permit_number }
    it { should validate_presence_of :address }
    it { should validate_presence_of :valuation }
    it { should validate_presence_of :fee }
    it { should validate_presence_of :owner_name }
    it { should validate_presence_of :contractor_name }
  end

  context 'relationships' do
    it { should belong_to :permit_type}
  end
end
