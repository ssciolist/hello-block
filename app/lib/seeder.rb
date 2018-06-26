class Seeder
  def create_building_permits(directory)
    Dir.glob("#{directory}/*").each do |file|
      CSV.foreach(file, headers: false) do |row|
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
      end
    end
  end
end
