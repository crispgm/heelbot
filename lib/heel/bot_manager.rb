module Heel
  class BotManager

    require "yaml"

    BOT_CONF_NAME = "heelspec/bots.yaml"

    @new_conf = false

    attr_reader :bot_list, :bot

    def initialize
      @bot_list ||= []
      load_bots
    end

    def init_bot(bot_name)
      begin
        require_relative "../../heelspec/#{bot_name}"
      rescue LoadError
        puts "#{bot_name} not found"
        return
      end
      bot_class_name = bot_name_to_class_name(bot_name)
      bot_class = Object.const_get("Heelspec::#{bot_class_name}")
      @bot = bot_class.new
    end

    def run_bot(bot_name, bot_cmd)
      init_bot(bot_name)
      @bot.run(bot_cmd)
    end

    def help_bot(bot_name)
      init_bot(bot_name)
      puts @bot.helptext
    end

    def get_triggers_of_bot
      @bot.triggers
    end

    def info_bot(bot_name)
      init_bot(bot_name)
      puts "Name:     #{bot_name}"
      puts "Version:  #{@bot.version}"
      puts "Summary:  #{@bot.summary}"
      puts "Author:   #{@bot.author}"
      puts "License:  #{@bot.license}"
      puts "Helptext: #{@bot.helptext}"
      puts "Triggers: #{@bot.triggers.join ', '}"
    end

    private

    def load_bots
      if File.exist? BOT_CONF_NAME
        @new_conf = false;
        @bot_list = YAML.load_file BOT_CONF_NAME
      else
        @new_conf = true
        f = File.new(BOT_CONF_NAME, "w")
        f.close
      end
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
