module Heel

  require "sinatra/base"

  class Server

    attr_writer :argv

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
          server_time = Time.now.to_i
          output = <<JSON
{
    "status": "listening",
    "version": "#{Heel::VERSION}",
    "server_time": "#{server_time}"
}
JSON
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