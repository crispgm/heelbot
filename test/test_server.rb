require "helper"
require "open-uri"

class TestServer < Minitest::Test
  context "test server" do
    setup do
      @webserver = Process.spawn("script/webrick.rb")

      sleep 1
    end

    should "init with port" do
      argv = ["--port=1111"]
      server = Heel::Server.new(argv)
      assert_equal(1111, server.port)
    end

    should "init without port" do
      server = Heel::Server.new([])
      assert_equal(9999, server.port)
    end

    should "return status" do
      content = open("http://127.0.0.1:9999/heels/status").read
      response = JSON.parse(content)

      assert_equal("listening", response["status"])
      assert_equal(Heel::VERSION, response["version"])
    end

    should "return 404 when not trigger" do
      assert_raises OpenURI::HTTPError do
        content = open("http://127.0.0.1:9999/heels/query?msg=hv1").read
        # response = JSON.parse(content)
        # assert_equal("trigger message error", response["text"])
      end
    end

    should "return data when trigger" do  
    end

    teardown do
      Process.kill 'TERM', @webserver
    end
  end
end