module Heelspec
  # rubocop:disable duplication
  class Eurocup2016 < Heel::Bot

    SCHEDULE_URL = "https://gist.github.com/crispgm/1eedbc85b23470a5b9ca81ac3072f8f1".freeze
    RESULT_URL = "http://www.uefa.com/uefaeuro/season=2016/matches/index.html".freeze

    def initialize
      @name     = "Euro Cup 2016"
      @version  = "2.0.0"
      @summary  = "[Deprecated] Query Euro Cup 2016 Assistant"
      @author   = "David Zhang"
      @license  = "MIT"
      @helptext = ""
      @triggers = []
    end

    def run(_cmd)
      if Heel::Util.console_mode?
        Heel::Shell.open SCHEDULE_URL
        Heel::Shell.open RESULT_URL
      else
        puts "Schedule: #{SCHEDULE_URL}, Result: #{RESULT_URL}"
      end
    end
  end
end
