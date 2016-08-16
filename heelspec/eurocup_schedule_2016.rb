module Heelspec
  class EurocupSchedule2016 < Heel::Bot
    def initialize
      @name     = "Euro Cup Schedule 2016"
      @version  = "1.0.0"
      @summary  = "[Deprecated] Query Euro Cup 2016 Schedule"
      @author   = "David Zhang"
      @license  = "MIT"
      @helptext = ""
      @triggers = []
    end

    def run(cmd)
      Heel::Shell.open "https://gist.github.com/crispgm/1eedbc85b23470a5b9ca81ac3072f8f1"
    end
  end
end