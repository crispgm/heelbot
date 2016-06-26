require "heel/bot"

module Heelspec
  class GroupMembers < Heel::Bot::Bot

    attr_reader :groups

    def initialize
      @bot_name = "Mail Group Manager"
      @bot_version = "1.0.0"

      @groups = {
        "dev" => {
          :description => "Development Integration Group",
          :members => ["zhangwanlong", "cuishichao", "yunting", "miaodongdong", "dengxi", "hanpeng03", "hezhipeng"]
        },
        "bravo" => {
          :description => "Bravo Team",
          :members => ["zhangwanlong", "cuishichao", "yunting", "miaodongdong", "dengxi"]
        }
      }
    end

    def run(cmd)
      if cmd.length == 0
        puts "Error: Nil group name"
        return
      end

      if cmd[0] == "all"
        print_all_groups
        return
      elsif cmd[0] == "list"
        list_group
        return
      end

      group_info = get_group cmd[0]
      if group_info != false
        print_group_info group_info
      else
        puts "Error: No such group #{cmd}"
      end
    end

    def list_group
      @groups.keys.each do |name|
        puts name
      end
    end

    def print_all_groups
      @groups.each do |name, info|
        print_group_info info
      end
    end

    def print_group_info(info)
      puts info[:description]
      puts info[:members].join ","
    end

    def get_group(group_name)
      if @groups.has_key? group_name
        @groups[group_name]
      else
        false
      end
    end
  end
end