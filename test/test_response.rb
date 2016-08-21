require "helper"

class TestResponse < Minitest::Test

  def setup
    @resp = Heel::Response.new({:input => "default"})
  end

  def test_init
    assert_equal({:input => "default"}, @resp.body)
  end

  def test_set_body
    @resp.body = "hello, response"
    assert_equal("hello, response", @resp.body)
  end

  def test_as_json
    assert_equal("{\"input\":\"default\"}", @resp.as_json)
  end

  def test_as_s
    @resp.body = "hello, response"
    assert_equal("hello, response", @resp.as_s)
  end

  def test_as_raw
    assert_equal({:input => "default"}, @resp.as_raw)
  end
end