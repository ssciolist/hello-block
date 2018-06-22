require 'CSV'

class CsvCleaner
  def original_csv_files
    Dir.glob('./csv/*')
  end

  def clean_csv_namer(file)
    file.scan(/\/csv\/(.*).csv/).flatten.first
  end

  def file_root
    '/Users/meganarellano/turing/3module/projects/denver-building-permit-scraper/cleaned/'
  end

  def row_containing_permit?(row)
    return false if row.first.nil? || row[3].nil?
    row.first.match?(/\d{4}-\d{2}-\d{2}/)
  end

  def append_stat_code(file_name)
    CSV.foreach(file_name) do |row|
      if row.first.is_a?(String) && row.first.include?("Stat Code:")
        @stat_code = row.first.scan(/Stat Code: (.*)/).flatten.first
      elsif row.first.is_a?(String) && row_containing_permit?(row)
        row << @stat_code
      end
    end
  end

  def output_clean_csv(destination, original_csv)
    CSV.open(destination, 'wb') do |csv_out|
      CSV.foreach(original_csv) do |row|
        if row.first.is_a?(String) && row.first.include?("Stat Code:")
          @stat_code = row.first.scan(/Stat Code: (.*)/).flatten.first
        elsif row.first.is_a?(String) && row_containing_permit?(row)
          row << @stat_code
        end
        csv_out << row if row_containing_permit?(row)
      end
    end
  end

  def rewrite_dates(new_csv, original_csv)
    CSV.open(new_csv, 'wb') do |csv_out|
      CSV.foreach(original_csv) do |row|
        row[0].gsub!('/', '-') if row[0].match?(/\d{2}\/\d{2}\/\d{4}/)
        csv_out << row
      end
    end
  end

  def batch_output
    original_csv_files.each do |file|
      destination = file_root + clean_csv_namer(file) + '.csv'
      output_clean_csv(destination, file)
    end
  end
end
