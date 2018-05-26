# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

CSV.foreach('./data/permit-type-legend.csv', headers: true, header_converters: :symbol) do |row|
  PermitType.create(id:     row[:stat_code],
                     name:   row[:name],
                     p_type:   row[:p_type],
                     p_type_2: row[:p_type_2],
                     p_type_3: row[:p_type_3])
end

Dir.glob('data/base/*').each do |file|
  CSV.foreach("./#{file}", headers: false) do |row|
    permit_na = "999"
    na = "(Not specified)"
    BuildingPermit.create!(date_issued:     row[0],
                           permit_number:   row[3],
                           address:         row[6],
                           sublocation:     row[8],
                           building_class:  row[11],
                           valuation:       (if row[15].present?
                                                row[15]
                                             else
                                                0
                                             end),
                           fee:             row[16],
                           owner_name:      (if row[18].present?
                                                row[18]
                                             else
                                                na
                                             end),
                           contractor_name: (if row[20].present?
                                                row[20]
                                             else
                                                na
                                             end),
                           permit_type_id:  (if row[22].present?
                                                row[22]
                                             else
                                                permit_na
                                             end)
                         )
    puts row[0]
  end
end
