require "heel/bot"
require "heel/mail"

module Heelspec
  class MailTemplate < Heel::Bot::Bot
    def initialize
      @bot_name = "Mail Template Generator"
      @bot_version = "1.0.0"
    end

    def run
      @mail = Heel::MailHelper.new
      to_people = ["zhangwanlong", "cuishichao"]
      @mail.add_to!(to_people, "@baidu.com")
      puts @mail.to
    end
  end
end