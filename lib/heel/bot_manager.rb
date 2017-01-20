module Heel
  class BotManager
    include Enumerable

    require "yaml"

    attr_reader :spec_path, :conf_path, :bots_path
    attr_reader :bot_list, :bot_instance
    attr_reader :triggers_loaded

    def initialize(spec_path)
      @spec_path = spec_path
      @conf_path = "#{@spec_path}/bots.yml"
      @bots_path = "../../#{@spec_path}"
      @bot_list ||= []
      @bot_instance = Hash.new
      @triggers_loaded = false

      load_bots
    end

    def each(&block)
      @bot_list.each do |bot|
        block.call(bot)
      end
    end

    def trigger_bot(raw_msg)
      get_triggers

      if !raw_msg.is_a? String
        return nil, nil
      end

      @triggers.each do |trigger_text, bot_name|
        if raw_msg.start_with? trigger_text
          # triggered
          argv = raw_msg.split(trigger_text).at(1)
          if argv != nil
            cmd = argv.split
          end

          output = ""
          if Heel::Util.console_mode?
            run_bot(bot_name)
          end

          return bot_name, output
        end
      end

      return nil, nil
    end

    def init_bot(bot_name)
      if !@bot_instance.has_key? bot_name
        begin
          filename = "#{spec_path}/#{bot_name}.bot"
          code = File.read(filename)
        rescue
          puts "#{bot_name} not found"
          return
        end
        
        @bot_instance[bot_name] = Heel::DSL::Bot.new do
          define_attr("name", "version", "author", "summary", "helptext", "license")
          instance_eval(code)
        end
      end

      if block_given?
        yield @bot_instance[bot_name]
      end
    end

    def run_bot(name)
      init_bot(name) do |bot|
        bot.implementation.block.call
      end
    end

    def help_bot(name)
      init_bot(name) do |bot|
        puts bot.helptext
      end
    end

    def info_bot(name)
      init_bot(name) do |bot|
        puts "Name:     #{bot.name}"
        puts "Version:  #{bot.version}"
        puts "Summary:  #{bot.summary}"
        puts "Author:   #{bot.author}"
        puts "License:  #{bot.license}"
        puts "Helptext: #{bot.helptext}"
        puts "Triggers: #{bot.triggers.keys.join ', '}"
      end
    end

    private

    def get_triggers
      return if triggers_loaded

      @triggers = Hash.new

      @bot_list.each do |bot_info|
        init_bot(bot_info["Name"]) do |bot|
          if !bot.triggers.empty?
            bot.triggers.each_key do |trigger|
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
  end
end
