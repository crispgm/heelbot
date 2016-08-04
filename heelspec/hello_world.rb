module Heelspec
  class HelloWorld < Heel::Bot
    def initialize
      @bot_name     = "Hello World"
      @bot_version  = "1.0.0"
      @bot_summary  = "Print Hello World"
      @bot_author   = "David Zhang"
      @bot_license  = "MIT"
      @bot_helptext = ""
    end

    def run(cmd)
      @msg = get_param(cmd, 0)
      puts @msg
    end
  end
end