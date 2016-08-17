module Heel

  require "webrick"

  class StatusServlet < WEBrick::HTTPServlet::AbstractServlet
    def do_GET request, response
      resp = Heel::Response.new
      resp.body = {
        :status => "listening",
        :version => "#{Heel::VERSION}",
        :time => Time.now.to_i
      }

      response.status = 200
      response['Content-Type'] = "application/json"
      response.body = resp.as_json
    end
  end

  class BotServlet < WEBrick::HTTPServlet::AbstractServlet
    def do_GET request, response
      @bot_manager = Heel::BotManager.new
      @triggers = Hash.new
      args = request.query["msg"]
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
            :text => output.strip
          }
          response.status = 200
          response['Content-Type'] = "application/json"
          response.body = resp.as_json
          return
        end
      end

      resp = Heel::Response.new
      resp.body = {
        :error => "No triggers matched"
      }

      response.status = 200
      response['Content-Type'] = "application/json"
      response.body = resp.as_json
    end
  end

  class Server

    attr_reader :argv
    attr_reader :port

    # HTTP server to handle requests for heels
    # Format:
    # https://ip:port/heels?text=[http-encoded-text]
    def initialize(argv)
      @argv = argv
      @port = "9999".to_i
      get_config
    end

    def serve
      server = WEBrick::HTTPServer.new :Port => @port

      server.mount '/heels/status', StatusServlet
      server.mount '/heels/query', BotServlet

      t = Thread.new { server.start }
      trap("INT") { server.shutdown }
      t.join
      server.start
    end

    private
    def get_config
      @argv.each do |arg|
        if arg.start_with? "--port="
          @port = arg.split("--port=").at(1).to_i
        end
      end
    end
  end
end