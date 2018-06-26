# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# CSV.foreach('./data/permit-type-legend.csv', headers: true, header_converters: :symbol) do |row|
#   PermitType.create(id:     row[:stat_code],
#                      name:   row[:name],
#                      p_type:   row[:p_type],
#                      p_type_2: row[:p_type_2],
#                      p_type_3: row[:p_type_3])
# end

Dir.glob('data/batch_23/*').each do |file|
  CSV.foreach("./#{file}", headers: false) do |row|
    permit_na = "999"
    na = "(Not specified)"
    BuildingPermit.create!(date_issued:     row[1],
                           permit_number:   row[2],
                           address:         row[3],
                           sublocation:     row[4],
                           building_class:  row[5],
                           valuation:       (if row[7].present?
                                                row[7]
                                             else
                                                0
                                             end),
                           fee:             row[8],
                           owner_name:      na,
                           contractor_name: (if row[9].present?
                                                row[9]
                                             else
                                                na
                                             end),
                           permit_type_id:  (if row[0].present?
                                                row[0]
                                             else
                                                permit_na
                                             end)
                         )
  end
end
