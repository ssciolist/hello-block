require 'rails_helper'

RSpec.describe Neighborhood, type: :model do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :geom }
  end

  context 'class methods' do
    context '.summarize_valuation' do
      it 'should return an activerecord relation with sum field equal to valuaution total' do
        CSV.foreach('./data/denver_nbhds_binary.csv', headers: true, header_converters: :symbol) do |row|
          Neighborhood.create!(
                             name:   row[:nbhd_name],
                             geom: row[:string_wkb]
                             )
        end
        type = PermitType.create(name: 'Single family, detached', p_type: '003')
        create(:building_permit, permit_number: '2018-COMMCON-1', address: "6301 East 17th Avenue Parkway", valuation: 90, permit_type: type)
        require 'pry'; binding.pry


        expect(Neighborhood.summarize_valuation(['2018%']).length).to eq(1)
        expect(Neighborhood.summarize_valuation(['2018%'])[0].sum).to eq(1)
      end
    end
  end
end
