module Heel
  class Command

    attr_reader :argv
    attr_reader :bot_manager

    def initialize(argv)
      @argv = argv
      @bot_manager = BotManager.new
    end

    def usage
      description = <<DESC
Heelbot Usage:

Version
    heel --version

Bot
    heel list
    heel help [bot_name]
    heel run [bot_name]

DESC

      puts description
    end

    def parse_cmd
      if argv[0].eql? "list"
        list
      elsif argv[0].eql? "help"
        @bot_manager.help_bot(argv[1])
      elsif argv[0].eql? "run"
        @bot_manager.run_bot(argv[1], argv.slice(2, argv.length))
      else
        usage
      end
    end

    private

    def list
      @bot_manager.bot_list.each do |bot|
        puts "#{bot["Name"]}, #{bot["Ver"]}"
      end
    end

  end
end
