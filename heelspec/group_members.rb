module Heelspec
  class GroupMembers < Heel::Bot

    attr_reader :groups

    def initialize
      @name     = "Mail Group Manager"
      @version  = "1.0.0"
      @summary  = "Mail Group Manager"
      @author   = "David Zhang"
      @license  = "MIT"
      @helptext = "group_members [group_name]"
      @triggers = ["!gm"]

      read_yml
      expand_names
    end

    def run(cmd)
      if cmd.length == 0
        puts "Error: Nil group name"
        return
      end

      if cmd[0] == "all"
        print_all_groups
        puts ""
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
      @groups.each do |_name, info|
        print_group_info info
        puts ""
      end
    end

    def print_group_info(info)
      puts info["description"]
      puts info["members"].join ","
      puts info["managers"].join ","
    end

    def get_group(group_name)
      if @groups.has_key? group_name
        @groups[group_name]
      else
        false
      end
    end

    private
    def read_yml
      yml_path = "heelspec/group_members/config.yml"

      if File.exist? yml_path
        @groups = YAML.load_file yml_path
      end
    end

    def expand_names
      if @groups != nil
        @groups.each do |key, group|
          group["members"] = group["members"].split ","
          group["managers"] = group["managers"].split ","
        end
      end
    end
  end
end
