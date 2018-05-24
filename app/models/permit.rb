class Permit < ApplicationRecord
  belongs_to :permit_type

  validates_presence_of :date_issued, :permit_number, :address,
                        :valuation, :fee, :owner_name, :contractor_name
end
