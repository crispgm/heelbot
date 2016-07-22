module Heelspec
  class AirQualityIndex < Heel::Bot

    require "open-uri"
    require "CGI"

    API_KEY = "fb45a134a153bbc65dddf61682da581c".freeze
    API_URL = "http://apis.baidu.com/apistore/aqiservice/aqi".freeze

    def initialize
      @bot_name     = "AQI Query"
      @bot_version  = "1.0.0"
      @bot_summary  = "Query realtime Air Quality Index"
      @bot_author   = "David Zhang"
      @bot_license  = "MIT"
      @bot_helptext = "iciba city_name\t\tQuery city_name"
    end

    def run(cmd)
      body = query(cmd[0])
      parse(body)
    end

    private

    def query(word)
      q = "#{API_URL}?city=#{CGI.escape(word)}"

      open q do |http|
        http.read
      end
    end

    def parse(body)
      puts body
    end
  end
end