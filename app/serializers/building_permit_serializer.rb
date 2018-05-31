class BuildingPermitSerializer < ActiveModel::Serializer
  attributes :permit_number, :address, :valuation,
             :date_issued, :owner_name, :contractor_name, :permit_type, :building_class

  def date_issued
    Time.parse(object.date_issued.to_s).strftime("%B %e, %Y")
  end

  def permit_type
    object.permit_type.name
  end

end
