# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

CSV.foreach('./data/permit-type-legend.csv', headers: true, header_converters: :symbol) do |row|
  PermitType.create!(id:     row[:stat_code],
                     name:   row[:name],
                     p_type:   row[:p_type],
                     p_type_2: row[:p_type_2],
                     p_type_3: row[:p_type_3])
end
