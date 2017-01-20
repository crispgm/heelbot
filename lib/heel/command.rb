module Heel
  # Heel::Command is to handle terminal commands
  class Command

    DEFAULT_SPEC_PATH     = "heelspec".freeze
    DEFAULT_TEMPLATE_PATH = "lib/bot_template/bot.liquid".freeze

    attr_reader :argv
    attr_reader :spec_path, :tpl_path
    attr_reader :bot_manager

    def initialize(argv, options = {})
      # merge with default options
      default_options = {
        :spec_path => DEFAULT_SPEC_PATH,
        :tpl_path  => DEFAULT_TEMPLATE_PATH
      }
      
      default_options.each do |key, value|
        if !options.has_key?(key)
          options[key] = value
        end
      end

      # assign members
      @argv      = argv
      @spec_path = options[:spec_path]
      @tpl_path  = options[:tpl_path]
      
      # init bot manager
      @bot_manager = Heel::BotManager.new(spec_path)
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

New Bot
    heel new  [bot_name]

DESC

      puts description
      "usage"
    end

    def parse_cmd
      case argv[0]
      when "list"
        list
      when "msg"
        msg(argv)
      when "help"
        help(argv)
      when "run"
        run(argv)
      when "info"
        info(argv)
      when "new"
        new_bot(argv)
      else
        usage
      end
    end

    private

    def msg(argv)
      return usage if argv.length <= 1

      triggered_bot = @bot_manager.trigger_bot(argv.slice(1, argv.length).join(" "))
      "msg, #{triggered_bot}"
    end

    def run(argv)
      return usage if argv.length <= 1

      @bot_manager.run_bot(argv[1])
      "run"
    end

    def help(argv)
      return usage if argv.length <= 1

      @bot_manager.help_bot(argv[1])
      "help"
    end

    def info(argv)
      return usage if argv.length <= 1

      @bot_manager.info_bot(argv[1])
      "info"
    end

    def list
      @bot_manager.each do |bot|
        puts bot["Name"]
      end

      "list"
    end

    def new_bot(argv)
      return usage if argv.length <= 1

      bot_info = {
        "name"     => argv[1].to_s,
        "version"  => "1.0.0",
        "summary"  => "A new Heel bot.",
        "author"   => "",
        "license"  => "MIT",
        "helptext" => "",
        "triggers" => []
      }

      options = {
        :tpl_path  => @tpl_path,
        :spec_path => @spec_path
      }
      Heel::NewBot.new(options).process(bot_info)

      "new"
    end
  end
end
