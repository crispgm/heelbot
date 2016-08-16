module Heel

  require "sinatra/base"

  class Server

    attr_accessor :argv

    attr_reader :ip
    attr_reader :port

    # HTTP server to handle requests for heels
    # Format:
    # https://ip:port/heels?text=[http-encoded-text]
    def initialize(argv)
      @argv = argv
      @ip   = "0.0.0.0".freeze
      @port = "9999".to_i
    end

    def serve
      get_ip_port

      $app_ip = @ip
      $app_port = @port

      @app = Sinatra.new do
        set :bind, $app_ip
        set :port, $app_port

        get "/heels/status" do
          resp = Heel::Response.new
          resp.body = {
            :status => "listening",
            :version => "#{Heel::VERSION}",
            :time => Time.now.to_i
          }
          resp.as_json
        end

        get "/heels/query/:args" do
          @bot_manager = Heel::BotManager.new
          @triggers = Hash.new
          args = params["args"]
          @bot_manager.bot_list.each do |bot|
            bot_instance = @bot_manager.init_bot(bot["Name"])
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
            if args.start_with? trigger_text
              # triggered
              argv = args.split(trigger_text).at(1)
              if argv != nil
                argv = argv.split
              end
              # run bot
              output = Heel::Util.capture_stdout do
                @bot_manager.run_bot(bot_name, argv)
              end
              # build response
              resp = Heel::Response.new
              resp.body = {
                :text => output
              }
              return resp.as_json
            end
          end
        end
      end

      @app.run!
    end

    def get_ip_port
      @argv.each do |arg|
        if arg.start_with? "--ip="
          @ip = arg.split("--ip=").at(1).to_s
        end
        if arg.start_with? "--port="
          @port = arg.split("--port=").at(1).to_i
        end
      end
    end
  end
end