require 'rails_helper'

RSpec.describe PermitType, type: :model do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :type }
  end

  context 'relationships' do
    it { should have_many :building_permits}
  end
end
