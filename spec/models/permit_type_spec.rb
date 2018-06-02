require 'rails_helper'

RSpec.describe PermitType, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :p_type }
  end

  describe 'relationships' do
    it { should have_many :building_permits}
  end
end
