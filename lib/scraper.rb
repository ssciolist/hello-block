require 'mechanize'
require 'open-uri'

class Scraper

  def page
    agent = Mechanize.new
    agent.get("https://www.denvergov.org/content/denvergov/en/denver-development-services/help-me-find-/building-permits.html")
  end

  def a_tags
    page.css('li a[adhocenable="false"]')
  end

  def links_after_2014
    a_tags.map do |item|
      clean_nokogiri_link_element(item) if find_year(item) > 2014
    end.compact
  end

  def find_year(item)
    item['href'].scan(/PermitRecords\/(.*)\//).flatten[0].to_i
  end

  def clean_nokogiri_link_element(item)
    if item['href'].include?(' ')
      new_href = item['href'].gsub!(' ', '%20')
      "https://www.denvergov.org" + new_href
    elsif item['href'].include?('https://www.denvergov.org')
      item['href']
    else
      'https://www.denvergov.org' + item['href']
    end
  end

  def file_name_builder(link)
    link.scan(/(20.*)/).flatten.fetch(0)
  end

  def file_root
    '/Users/meganarellano/turing/3module/projects/hello-block/data/'
  end

  def create_single_file(link)
    file_name = file_root + file_name_builder(link)
    File.open(file_name, 'wb') do |file|
      file << open(link).read
    end
  end

  def take_files
    links.each do |link|
      create_single_file(link)
    end
  end
end
