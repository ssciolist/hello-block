# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

CSV.foreach('./data/permit-type-legend.csv', headers: true, header_converters: :symbol) do |row|
  Neighborhood.create(
                     name:   row[:name],
                     geom: row[:string_wkb]
                     )
end
