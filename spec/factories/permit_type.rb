FactoryBot.define do
  factory :permit_type, class: PermitType do
    name { Faker::Name.name}
    p_type { Faker::Name.name}
  end
end
