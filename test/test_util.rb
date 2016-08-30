require "helper"

class TestUtil < Minitest::Test
  context "test util functions" do
    context "capture outputs" do
      should "capture hello world as output" do
        output = Heel::Util.capture_stdout do
          puts "hello, world"
        end
        assert_equal("hello, world\n", output)
      end
    end

    context "get modes" do
      should "return web mode" do
        $runtime_mode = Heel::Util::RUNTIME_WEB
        assert_equal(true, Heel::Util.web_mode?)
      end

      should "return console mode" do
        $runtime_mode = Heel::Util::RUNTIME_CONSOLE
        assert_equal(true, Heel::Util.console_mode?)
      end

      should "return false if global var is not set" do
        $runtime_mode = nil
        assert_equal(false, Heel::Util.console_mode?)
        assert_equal(false, Heel::Util.web_mode?)
      end
    end
  end
end