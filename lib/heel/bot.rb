module Heel
  class Bot
    attr_accessor :name
    attr_accessor :version
    attr_accessor :summary
    attr_accessor :author
    attr_accessor :license
    attr_accessor :helptext
    attr_accessor :triggers

    def run(cmd)
      print "Bot not implemented"
    end

    def serve(request)
      { :text => "Bot not implemented"}
    end

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

    def inspect
      puts "#<Heel::Bot> @name=#{name}"
    end
  end
end
