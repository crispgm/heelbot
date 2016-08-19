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
    heel msg  [trigger_msg]
    heel help [bot_name]
    heel run  [bot_name]
    heel info [bot_name]

DESC

      puts description
    end

    def parse_cmd
      if argv[0].eql? "list"
        list
        "list"
      elsif argv[0].eql? "msg"
        triggered_bot = trigger_msg(argv.slice(1, argv.length))
        "msg, #{triggered_bot}"
      elsif argv[0].eql? "help"
        if (argv.length <= 1)
          usage
          return "usage"
        end
        @bot_manager.help_bot(argv[1])
        "help"
      elsif argv[0].eql? "run"
        if (argv.length <= 1)
          usage
          return "usage"
        end
        @bot_manager.run_bot(argv[1], argv.slice(2, argv.length))
        "run"
      elsif argv[0].eql? "info"
        if (argv.length <= 1)
          usage
          return "usage"
        end
        @bot_manager.info_bot(argv[1])
        "info"
      else
        usage
        "usage"
      end
    end

    private

    def list
      @bot_manager.bot_list.each do |bot|
        puts "#{bot["Name"]}"
      end
    end

    def trigger_msg(argv)
      @triggers = Hash.new
      @bot_manager.bot_list.each do |bot|
        @bot_manager.init_bot(bot["Name"])
        bot_triggers = @bot_manager.get_triggers_of_bot
        if !bot_triggers.empty?
          bot_triggers.each do |trigger|
            if @triggers.has_key? trigger
              puts "Conflict: Trigger #{trigger} is existed."
            end
            @triggers[trigger] = bot["Name"]
          end
        end
      end

      @triggers.each do |trigger_text, bot_name|
        if argv[0].start_with? trigger_text
          # triggered, run bot
          @bot_manager.run_bot(bot_name, argv.slice(1, argv.length))
          return bot_name
        end
      end
    end

  end
end
