module Heel
  class BotManager

    require "yaml"

    BOT_CONF_NAME = "heelspec/bots.yaml".freeze

    attr_reader :conf_path
    attr_reader :bot_list, :bot_instance
    attr_reader :triggers_loaded

    def initialize(conf_path = BOT_CONF_NAME)
      @conf_path = conf_path
      @bot_list ||= []
      @bot_instance = Hash.new
      @triggers_loaded = false

      load_bots
    end

    def trigger_bot(raw_msg, raw_request = {})
      get_triggers

      @triggers.each do |trigger_text, bot_name|
        if raw_msg.start_with? trigger_text
          # triggered
          argv = raw_msg.split(trigger_text).at(1)
          if argv != nil
            cmd = argv.split
          end
          # run bot
          run_bot(bot_name, cmd, raw_request)
          return bot_name
        end
      end
    end

    def init_bot(bot_name)
      if !@bot_instance.has_key? bot_name
        begin
          require_relative "../../heelspec/#{bot_name}"
        rescue LoadError
          puts "#{bot_name} not found"
          return
        end
        bot_class_name = bot_name_to_class_name(bot_name)
        bot_class = Object.const_get("Heelspec::#{bot_class_name}")
        @bot_instance[bot_name] = bot_class.new
      end

      if block_given?
        yield @bot_instance[bot_name]
      end
    end

    def run_bot(bot_name, cmd, request = {})
      init_bot(bot_name) do |bot|
        bot.run(cmd)
      end
    end

    def help_bot(bot_name)
      init_bot(bot_name) do |bot|
        puts bot.helptext
      end
    end

    def info_bot(bot_name)
      init_bot(bot_name) do |bot|
        puts "Name:     #{bot.name}"
        puts "Version:  #{bot.version}"
        puts "Summary:  #{bot.summary}"
        puts "Author:   #{bot.author}"
        puts "License:  #{bot.license}"
        puts "Helptext: #{bot.helptext}"
        puts "Triggers: #{bot.triggers.join ', '}"
      end
    end

    private

    def get_triggers
      return if triggers_loaded

      @triggers = Hash.new

      @bot_list.each do |bot_info|
        init_bot(bot_info["Name"]) do |bot|
          if !bot.triggers.empty?
            bot.triggers.each do |trigger|
              if @triggers.has_key? trigger
                puts "Conflict: Trigger #{trigger} is existed."
              end
              @triggers[trigger] = bot_info["Name"]
            end
          end
        end
      end

      triggers_loaded = true
    end

    def load_bots
      if File.exist? @conf_path
        @bot_list = YAML.load_file @conf_path
      else
        f = File.new(@conf_path, "w")
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
