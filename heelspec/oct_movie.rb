module Heelspec
  class OctMovie < Heel::Bot

    require "open-uri"
    require "nokogiri"

    OCT_MOVIE_DOMAIN_NAME = "http://www.octeshow.com/".freeze
    OCT_MOVIE_SCHEDULE_PAGE_URL = "http://www.octeshow.com/index.php?a=index&m=News&id=74".freeze

    BEARY_CHAT_INCOMING_URL = "https://hook.bearychat.com/=bw7pB/incoming/449523bbe7877dd17064a761c85c5d50".freeze

    def initialize
      @name     = "OCT Movie"
      @version  = "1.0.0"
      @summary  = "Schedule of OCT Huaxia Theater"
      @author   = "David Zhang"
      @license  = "MIT"
      @helptext = ""
      @triggers = ["!octmovie"]
    end

    # rubocop:disable Lint/UnusedMethodArgument
    def run(cmd)
      puts get_schedule_img
    end

    def serve(request)
      imgs = get_schedule_img
      img_data = []
      imgs.each do |img|
        img_data << {
          :url => img
        }
      end

      data = { 
        :text => "OCT Movie Schedule",
        :attachments => [
          :title => "",
          :text => "",
          :color => "#666666",
          :images => img_data
        ]
      }

      uri = URI.parse(BEARY_CHAT_INCOMING_URL)
      req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
      req.body = data.to_json
      res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(req)
      end

      p res.body

      data
    end

    private
    def get_schedule_img
      page = Nokogiri::HTML(open(OCT_MOVIE_SCHEDULE_PAGE_URL))
      page.encoding = "UTF-8"
      # get two pages url
      url = []
      page.css("ul.dropdown-menu-right")[0].css("li").each do |item|
        url << ("" << OCT_MOVIE_DOMAIN_NAME << item.css("a")[0]["href"])
      end
      
      # get photos
      imgs = []
      url.each do |page_url|
        page = Nokogiri::HTML(open(page_url))
        page.encoding = "UTF-8"
        div = page.css("div.table-responsive").first
        imgs << ("" << OCT_MOVIE_DOMAIN_NAME << div.css("img")[0]["src"])
      end

      imgs
    end
  end
end