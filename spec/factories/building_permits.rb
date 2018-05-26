FactoryBot.define do
  factory :building_permit, class: BuildingPermit do
    date_issued { Faker::Date.between(2.days.ago, 30.days.ago) }
    sequence(:permit_number) { |n| "2018-PLUMB-#{n}" }
    address { ['2090 Ivanhoe Street', '2075 Jasmine Street', '2022 Jasmine Street'].sample }
    valuation { rand(100..1000) }
    owner_name { Faker::Name.name}
    contractor_name { Faker::Company.bs}
  end
end
