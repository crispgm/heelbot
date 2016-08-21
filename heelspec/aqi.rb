module Heelspec
  class Aqi < Heel::Bot

    require "open-uri"
    require "cgi"
    require "json"

    API_KEY = "fb45a134a153bbc65dddf61682da581c".freeze
    API_URL = "http://apis.baidu.com/apistore/aqiservice/aqi".freeze

    def initialize
      @name     = "AQI Query"
      @version  = "1.0.0"
      @summary  = "Query realtime Air Quality Index"
      @author   = "David Zhang"
      @license  = "MIT"
      @helptext = "aqi city_name"
      @triggers = ["!aqi"]
    end

    def run(cmd)
      @city = get_param(cmd, 0)
      if @city == nil
        puts "Error: no city input"
        return
      end
      body = query(@city.strip)
      parse(body)
    end

    private

    def query(word)
      open("#{API_URL}?city=#{CGI.escape(word)}", "apikey" => API_KEY) do |http|
        http.read
      end
    end

    def parse(body)
      parsed = JSON.parse(body)

      if !parsed["retData"].empty?
        puts "AQI of #{@city} is #{parsed["retData"]["aqi"]}."
      else
        puts "AQI of #{@city} is not found."
      end
    end
  end
end
