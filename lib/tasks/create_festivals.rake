require 'csv'
require 'open-uri'
require 'nokogiri'
namespace :create_festivals do
  desc "Creatre an event"
  task :update_all => :environment do
    require "csv"
    CSV.foreach("festival_urls.csv") do |row|
      url = row[0].match('[^"]*')[0]
      canceled = false
      # url = "https://www.musicfestivalwizard.com/festivals/rockin-the-rivers-2019-2/"
      html = open(url).read
      doc = Nokogiri::HTML(html)
      doc.css('.hubscene .heading-breadcrumb a').each do |t| 
        if t.children.text == "canceled"
          canceled = true
        end
      end
      if (doc.search('div.col div.hubscene a')[0] != nil) && !canceled
        doc.search('div.col div.hubscene a').each do |element|
          text_value = element.attributes["href"].value
          p text_value if text_value.match?(/www.google.com/)
        end
      end
    end
  end
end
