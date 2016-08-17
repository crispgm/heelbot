require "helper"

class TestServer < Minitest::Test
  
  include Rack::Test::Methods

  def setup
    argv = ["--ip=1.1.1.1", "--port=1111"]
    @server = Heel::Server.new(argv)
  end

  def test_init
    assert_equal("0.0.0.0", @server.ip)
    assert_equal(9999, @server.port)
  end

  def test_get_ip_port
    @server.get_ip_port
    assert_equal("1.1.1.1", @server.ip)
    assert_equal(1111, @server.port)
  end
end