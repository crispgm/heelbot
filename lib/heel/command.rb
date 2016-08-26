module Heel
  class Command

    DEFAULT_SPEC_PATH     = "heelspec".freeze
    DEFAULT_TEMPLATE_PATH = "lib/bot_template/bot.liquid".freeze

    attr_reader :argv
    attr_reader :bot_manager
    attr_reader :spec_path, :tpl_path

    def initialize(argv, spec_path = DEFAULT_SPEC_PATH, tpl_path = DEFAULT_TEMPLATE_PATH)
      @argv = argv
      @bot_manager = Heel::BotManager.new(spec_path)
      @spec_path = spec_path
      @tpl_path = tpl_path
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

      triggered_bot = @bot_manager.trigger_bot(argv.slice(1, argv.length).join(" "), {})
      "msg, #{triggered_bot}"
    end

    def run(argv)
      return usage if argv.length <= 1

      @bot_manager.run_bot(argv[1], argv.slice(2, argv.length))
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
      @bot_manager.list_bot
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

      Heel::NewBot.new(@tpl_path, @spec_path).process bot_info

      "new"
    end
  end
end
