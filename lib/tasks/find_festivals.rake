require 'csv'
require 'open-uri'
require 'nokogiri'
namespace :find_festivals do
  desc "Scraping festivals and to store as CSV"
  task :find_all => :environment do
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    filepath = 'festival_urls.csv'
    page = 1
    html = open("https://www.musicfestivalwizard.com/all-festivals/page/1/?festival_guide=us-festivals&month&festivalgenre&festivaltype&festival_length&festival_size&camping&artist&company&sdate=Jan%201%2C%202020&edate=Dec%2031%2C%202020#038;month&festivalgenre&festivaltype&festival_length&festival_size&camping&artist&company&sdate=Jan+1%2C+2020&edate=Dec+31%2C+2020").read
    doc = Nokogiri::HTML(html)
    CSV.open(filepath, 'wb', csv_options) do |csv|
      while doc.search('.search-res').children[0].text != "Your search has returned 0 festivals!" do
        fes_num = 0
          until doc.search('#artist-lineup-container .image-wrap a')[fes_num].nil?
            col1 = doc.search('#artist-lineup-container .image-wrap a')[fes_num].attributes["href"].value
            col2 = doc.search('.entry-title h2 a')[fes_num].children.text
            event_array = []
            doc.search('.entry-title .search-meta')[fes_num].children.text.each_line{ |s| event_array << s.lstrip.rstrip }
            col3 = event_array[1]
            col4 = event_array[2].chomp("/ Book Tickets").rstrip
            csv << [col1, col2, col3, col4]
            fes_num += 1
          end
        page += 1
        html = open("https://www.musicfestivalwizard.com/all-festivals/page/#{page}/?festival_guide=us-festivals&month&festivalgenre&festivaltype&festival_length&festival_size&camping&artist&company&sdate=Jan%201%2C%202020&edate=Dec%2031%2C%202020#038;month&festivalgenre&festivaltype&festival_length&festival_size&camping&artist&company&sdate=Jan+1%2C+2020&edate=Dec+31%2C+2020").read
        doc = Nokogiri::HTML(html)
      end
    end
  end
end
