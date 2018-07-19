require 'csv'

class CsvCleaner
  def clean_csv_namer(file)
    file.scan(/\d{6}\/(.*)/).flatten.first
  end

  def file_root
    '/Users/meganarellano/turing/3module/projects/hello-block/tmp'
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

  def output_clean_csv(original_csv, destination)
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

  def rewrite_dates_from_mmddyy_with_dashes(original_csv, destination)
    CSV.open(destination, 'wb') do |csv_out|
      CSV.foreach(original_csv) do |row|
        if row[0].match?(/\d{2}\/\d{2}\/\d{4}/)
          mm_dd_yyyy = row[0].split('/')
          row[0] = mm_dd_yyyy[2] + '-' + mm_dd_yyyy[0] + '-' + mm_dd_yyyy[1]
        end
        csv_out << row
      end
    end
  end

  def batch_output_cleaned(date)
    Dir.glob("#{file_root}/#{date}/*.csv").each do |file|
      destination = file_root + "/#{date}/to_process/" + clean_csv_namer(file)
      output_clean_csv(file, destination)
    end
  end
end
