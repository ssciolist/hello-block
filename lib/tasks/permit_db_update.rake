require 'mechanize'
require 'roo'
require 'roo-xls'
require 'csv'

desc 'update the permit table'
task update_permit_table: :environment do

  date = Date.today.strftime('%Y%m%d')
  files_in_system = ScrapedFile.all.pluck(:url)
  scraper = Scraper.new
  excel_converter = ExcelConverter.new
  csv_cleaner = CsvCleaner.new
  seeder = Seeder.new

  unless scraper.find_unscraped_files(files_in_system).empty?
    date_directory = Dir.mkdir("/Users/meganarellano/turing/3module/projects/hello-block/data2/#{date}")
    files_to_process = Dir.mkdir("/Users/meganarellano/turing/3module/projects/hello-block/data2/#{date}/to_process")

    unscraped_files = scraper.find_unscraped_files(files_in_system)
    scraper.batch_create_files(unscraped_files)
    excel_converter.batch_file_conversion("#{date}")
    csv_cleaner.batch_output_cleaned(date)
    seeder.create_building_permits(files_to_process)

    unscraped_files.each do |url|
      ScrapedFile.create(url: url)
    end
  end
end
