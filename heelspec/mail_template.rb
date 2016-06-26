require "heel/bot"

module Heelspec
  class MailTemplate < Heel::Bot::Bot
    def initialize
      @bot_name = "Mail Template Generator"
      @bot_version = "1.0.0"
    end

    def run
      puts @bot_name, @bot_version
    end
  end
end