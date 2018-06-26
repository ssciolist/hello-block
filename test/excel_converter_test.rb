require 'minitest/autorun'
require 'minitest/pride'
require './app/lib/excel_converter.rb'

class ExcelConverterTest < Minitest::Test
  def setup
    @ec = ExcelConverter.new
  end

  def test_it_exists
    assert_instance_of ExcelConverter, @ec
  end

  def test_it_returns_at_least_63_files
    assert @ec.data_files.count > 62
  end

  def test_it_can_name_a_file
    last_file = @ec.data_files.first
    file_name = @ec.csv_namer(last_file)
require 'pry'; binding.pry
    refute file_name.match?(/xls/)
    refute file_name.match?(/data\//)
  end
end
