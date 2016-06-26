require "heel/bot"

module Heelspec
  class GroupMembers < Heel::Bot::Bot
    def initialize
      @bot_name = "Mail Group Manager"
      @bot_version = "1.0.0"
    end

    def run(cmd)
      dev_integration_group = ["zhangwanlong", "cuishichao", "yunting", "miaodongdong", "dengxi", "hanpeng03", "hezhipeng"]
      bravo_group = ["zhangwanlong", "cuishichao", "yunting", "miaodongdong", "dengxi"]

      if cmd.length == 0
        puts "Error: Nil group name"
        return
      end

      if cmd[0].eql? "all"
        puts "Dev Integration"
        puts "#{dev_integration_group}"
        puts "Bravo Group"
        puts "#{bravo_group}"
      elsif cmd[0].eql? "dev"
        puts "Dev Integration"
        puts "#{dev_integration_group}"
      elsif cmd[0].eql? "bravo"
        puts "Bravo Group"
        puts "#{bravo_group}"
      else
        puts "Error: No such group #{cmd}"
      end

    end
  end
end