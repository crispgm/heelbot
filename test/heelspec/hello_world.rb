module Heelspec
  class HelloWorld < Heel::Bot
    def initialize
      @name     = "Hello World"
      @version  = "1.0.0"
      @summary  = "Print Hello World"
      @author   = "David Zhang"
      @license  = "MIT"
      @helptext = ""
      @triggers = ["!hw", "!helloworld"]
    end

    def run(cmd)
      @msg = get_param(cmd, 0)
      puts @msg
    end

    def serve(request)
      { :text => "hello,world"}
    end
  end
end