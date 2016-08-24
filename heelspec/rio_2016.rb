module Heelspec
  class Rio2016 < Heel::Bot

    require "open-uri"
    require "nokogiri"

    def initialize
      @name     = "Medal Count of RIO 2016 Olympic Games"
      @version  = "1.0.0"
      @summary  = "Query realtime medal count of RIO 2016 Olympic Games"
      @author   = "David Zhang"
      @license  = "MIT"
      @helptext = ""
      @triggers = ["!rio"]
      @title = %w(Rank Code Gold Silver Bronze Total Country)
      @medal_list = []
    end

    # rubocop:disable Lint/UnusedMethodArgument
    def run(cmd)
      get_rio

      puts @title.join "\t"
      @medal_list.each do |country|
        puts country.join "\t"
      end
    end

    def serve(request)
      get_rio

      result = ""
      result << "|" << @title.join("|") << "|" << "<br>"
      result << "|-|-|-|-|-|-|-|" << "<br>"
      @medal_list.each do |country|
        result << "|" << country.join("|") << "|" << "<br>"
      end
      { :text => result }
    end

    private
    def get_rio
      page = Nokogiri::HTML(open("https://www.rio2016.com/en/medal-count-country"))
      page.encoding = "UTF-8"

      page.css("tr.table-medal-countries__link-table").each do |tr|
        index = tr.css("td.col-1")[0].css("strong")[0].css("strong")[0].text
        country = tr.css("td.col-2")[0].css("span.country")[0].text
        country_full = tr.css("td.col-3")[0].css("span.country")[0].text
        gold = tr.css("td.col-4")[0].text
        silver = tr.css("td.col-5")[0].text
        bronze = tr.css("td.col-6")[0].text
        total = tr.css("td.col-7")[0].css("strong")[0].text
        @medal_list << [index, country, gold, silver, bronze, total, country_full]
      end
    end
  end
end
