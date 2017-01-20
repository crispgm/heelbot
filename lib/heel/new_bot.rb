module Heel
  # Heel::NewBot create new bot by liquid template
  class NewBot

    require "liquid"

    attr_reader :tpl_path
    attr_reader :spec_path
    attr_reader :bot_path

    def initialize(options)
      @tpl_path  = options[:tpl_path]
      @spec_path = options[:spec_path]
    end

    def process(bot_info)
      @bot_path = "#{spec_path}/#{bot_info["name"]}.bot"
      if File.exist? @bot_path
        raise BotExistedError, "Bot #{bot_info["name"]} is existed."
      end

      template_content = ""

      File.open(@tpl_path, "r") do |f|
        f.each_line do |line|
          template_content << line
        end
      end

      liquid = Liquid::Template.parse(template_content)
      bot_info["name"] = Heel::Util.bot_name_to_class_name(bot_info["name"])
      new_bot = liquid.render(bot_info)

      File.open(@bot_path, "w") do |f|
        f.puts new_bot
      end
    end
  end

  class BotExistedError < StandardError; end
end
