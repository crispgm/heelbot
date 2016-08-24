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
      @bot_manager = Heel::BotManager.new(Heel::Command::DEFAULT_SPEC_PATH)
      args = request.query["msg"]

      bot_name, output = @bot_manager.trigger_bot(args, request)

      resp = Heel::Response.new
      resp.body = output

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