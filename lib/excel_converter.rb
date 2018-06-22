require 'roo'
require 'roo-xls'

class ExcelConverter
  def data_files
    Dir.glob('./data/*/*')
  end

  def csv_namer(file)
    file.scan(/\/data\/.{4}\/(.*).xls/).flatten.first
  end

  def file_root
    '/Users/meganarellano/turing/3module/projects/denver-building-permit-scraper/csv/'
  end

  def convert_to_csv
    data_files.each do |file|
      permit_descriptor = csv_namer(file)
      single_file_conversion(file, permit_descriptor)
    end
  end

  def single_file_conversion(source, destination)
    spreadsheet = Roo::Spreadsheet.open(source)
    csv = spreadsheet.sheet('Sheet1').to_csv
    file_name = file_root + destination + '.csv'
    CSV.open(file_name, "wb") do |file|
      CSV.parse(csv).each do |row|
        file << row unless row.all? { |data| data.nil? }
      end
    end
  end
end
