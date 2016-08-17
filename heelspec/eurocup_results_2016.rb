module Heelspec
  # rubocop:disable duplication
  class EurocupResults2016 < Heel::Bot
    def initialize
      @name     = "Euro Cup Results 2016"
      @version  = "1.0.0"
      @summary  = "[Deprecated] Query Euro Cup 2016 Results"
      @author   = "David Zhang"
      @license  = "MIT"
      @helptext = ""
      @triggers = []
    end

    # rubocop:disable Lint/UnusedMethodArgument
    def run(cmd)
      url = "http://www.uefa.com/uefaeuro/season=2016/matches/index.html"
      if Heel::Util.console_mode?
        Heel::Shell.open url
      end
    end
  end
end