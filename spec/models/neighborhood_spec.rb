require 'rails_helper'

RSpec.describe Neighborhood, type: :model do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :geom }
  end

  context 'class methods' do
    context '.summarize_valuation' do
      it 'should return an activerecord relation with sum field equal to valuaution total' do
        type = PermitType.create(name: 'Single family, detached', p_type: '003')
        permit = create(:building_permit, permit_type: type)
        create(:neighborhood)
        
        expect(Neighborhood.summarize_valuation(['2018%']).length).to eq(1)
        expect(Neighborhood.summarize_valuation(['2018%'])[0].sum).to eq(1)
      end
    end
  end
end
