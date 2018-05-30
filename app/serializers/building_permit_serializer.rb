class BuildingPermitSerializer < ActiveModel::Serializer
  attributes :permit_number, :address,
             :valuation, :owner_name, :contractor_name

  def date_issued
    Time.parse(object.date_issued.to_s).strftime("%B%e, %Y")
  end

end
