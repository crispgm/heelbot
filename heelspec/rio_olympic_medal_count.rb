module Heelspec
  class RioOlympicMedalCount < Heel::Bot

    require "open-uri"
    require "nokogiri"

    def initialize
      @bot_name     = "Medal Count of RIO 2016 Olympic Games"
      @bot_version  = "1.0.0"
      @bot_summary  = "Query realtime medal count of RIO 2016 Olympic Games"
      @bot_author   = "David Zhang"
      @bot_license  = "MIT"
      @bot_helptext = ""
    end

    def run(cmd)
      page = Nokogiri::HTML(open("https://www.rio2016.com/en/medal-count-country"))
      page.encoding = "UTF-8"

      puts "Rank\tCode\tGold\tSilver\tBronze\tTotal\tCountry"

      page.css("tr.table-medal-countries__link-table").each do |tr|
        index = tr.css("td.col-1")[0].css("strong")[0].css("strong")[0].text
        country = tr.css("td.col-2")[0].css("span.country")[0].text
        country_full = tr.css("td.col-3")[0].css("span.country")[0].text
        gold = tr.css("td.col-4")[0].text
        silver = tr.css("td.col-5")[0].text
        bronze = tr.css("td.col-6")[0].text
        total = tr.css("td.col-7")[0].css("strong")[0].text
        puts "#{index}\t#{country}\t#{gold}\t#{silver}\t#{bronze}\t#{total}\t#{country_full}"
      end
    end
  end
end
