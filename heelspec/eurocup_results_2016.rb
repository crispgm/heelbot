module Heelspec
  class EurocupResults2016 < Heel::Bot
    def initialize
      @bot_name = "Euro Cup Results 2016"
      @bot_version = "1.0.0"
    end

    def run(cmd)
      Heel::Shell.open "http://www.uefa.com/uefaeuro/season=2016/matches/index.html"
    end
  end
end