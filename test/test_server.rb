require "helper"

class TestServer < Minitest::Test
  def setup
    @webserver = Process.spawn("script/webrick.rb")

    sleep 1
  end

  def test_init_with_port
    argv = ["--port=1111"]
    server = Heel::Server.new(argv)
    assert_equal(1111, server.port)
  end

  def test_init_without_port
    server = Heel::Server.new([])
    assert_equal(9999, server.port)
  end

  def test_server
    require "open-uri"

    content = open("http://127.0.0.1:9999/heels/status").read
    response = JSON.parse(content)

    assert_equal("listening", response["status"])
    assert_equal(Heel::VERSION, response["version"])

    content = open("http://127.0.0.1:9999/heels/query?msg=!hw%20hello,world").read
    response = JSON.parse(content)
    assert_equal("hello,world", response["text"])
  end

  def teardown
    Process.kill 'TERM', @webserver
  end
end