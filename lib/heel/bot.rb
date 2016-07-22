module Heel
  class Bot
    attr_accessor :bot_name
    attr_accessor :bot_version
    attr_accessor :bot_summary
    attr_accessor :bot_author
    attr_accessor :bot_license
    attr_accessor :bot_helptext

    public
    def get_param(cmd, index)
      begin
        if cmd[index].empty?
          puts "Error: Cannot get param ##{index}"
          nil
        else
          cmd[index]
        end
      rescue
        puts "Error: Cannot get param ##{index}"
        nil
      end
    end
  end
end