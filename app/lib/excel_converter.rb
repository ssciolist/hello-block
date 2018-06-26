require 'roo'
require 'roo-xls'

class ExcelConverter
  def data_files
    Dir.glob('./data/*/*')
  end

  def csv_namer(file)
    file.scan(/data\/\d{8}\/(.*).xls/).flatten.first
  end

  def file_destination_root
    '/Users/meganarellano/turing/3module/projects/hello-block/data'
  end

  def convert_to_csv
    data_files.each do |file|
      destination = csv_namer(file)
      single_file_conversion(file, destination)
    end
  end

  def single_file_conversion(source, destination)
    spreadsheet = Roo::Spreadsheet.open(source)
    csv = spreadsheet.sheet('Sheet1').to_csv
    CSV.open(destination, "wb") do |file|
      CSV.parse(csv).each do |row|
        file << row unless row.all? { |data| data.nil? }
      end
    end
  end

  def batch_file_conversion(date)
    Dir.glob("data/#{date}/*.xls").each do |file|
      destination = file_destination_root + "/#{date}/" + csv_namer(file) + '.csv'
      single_file_conversion(file, destination)
    end
  end
end
