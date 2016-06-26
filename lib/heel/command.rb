module Heel
  class Command

    attr_reader :argv
    attr_reader :bot_list

    def initialize(argv)
      @argv = argv
      # write here, before implementing `add`
      @bot_list = ["mail_template", "eurocup_schedule_2016", "group_members"].freeze
    end

    def usage
      description = <<DESC
Heelbot Usage:

Version
    heel --version

Bot
    heel bot list
    heel bot add [bot_name]
    heel bot remove [bot_name]
    heel run [bot_name]

DESC

      puts description
    end

    def parse_cmd
      if argv[0].eql? "bot"
        if argv[1].eql? "list"
          list
        elsif argv[1].eql? "add"
          puts "add"
        elsif argv[1].eql? "remove"
          puts "remove"
        else
          usage
        end
      elsif argv[0].eql? "run"
        run(argv[1], argv.slice(2, argv.length))
      else
        usage
      end
    end

    private

    def list
      @bot_list.each do |bot_name|
        puts "#{bot_name}"
      end
    end

    def run(bot_name, bot_cmd)
      require_relative "../../heelspec/#{bot_name}"
      bot_class_name = bot_name_to_class_name(bot_name)
      bot_class = eval("Heelspec::#{bot_class_name}")
      bot = bot_class.new
      bot.run(bot_cmd)
    end

    def bot_name_to_class_name(bot_name)
      ary_bot_name = bot_name.split "_"
      class_name = ""
      ary_bot_name.each do |name_part|
        class_name << name_part.capitalize
      end
      class_name
    end

  end
end