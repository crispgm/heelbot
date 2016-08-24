module Heelspec
  class OctMovie < Heel::Bot

    require "open-uri"
    require "nokogiri"

    OCT_MOVIE_DOMAIN_NAME = "http://www.octeshow.com/".freeze
    OCT_MOVIE_SCHEDULE_PAGE_URL = "http://www.octeshow.com/index.php?a=index&m=News&id=74".freeze

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
      { 
        :text => "OCT Movie Schedule",
        :attachments => [
          {
            :title => "",
            :text => "",
            :color => "#666666",
            :images => [
              {
                :url => get_schedule_img
              }
            ]
          }
        ]
      }
    end

    private
    def get_schedule_img
      page = Nokogiri::HTML(open(OCT_MOVIE_SCHEDULE_PAGE_URL))
      page.encoding = "UTF-8"

      div = page.css("div.table-responsive").first
      "" << OCT_MOVIE_DOMAIN_NAME << div.css("img")[0]["src"]
    end
  end
end