require "helper"

class TestResponse < Minitest::Test
  context "test response" do
    setup do
      @resp = Heel::Response.new({:input => "default"})
    end

    should "init with input" do
      assert_equal({:input => "default"}, @resp.body)
    end

    should "set body" do
      @resp.body = "hello, response"
      assert_equal("hello, response", @resp.body)
    end

    should "output in json" do
      assert_equal("{\"input\":\"default\"}", @resp.as_json)
    end

    should "output in string" do
      @resp.body = "hello, response"
      assert_equal("hello, response", @resp.as_s)
    end

    should "output raw" do
      assert_equal({:input => "default"}, @resp.as_raw)
    end
  end
end