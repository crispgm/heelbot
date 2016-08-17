require "helper"

class TestUtil < Minitest::Test
  def test_capture
    output = Heel::Util.capture_stdout do
      puts "hello, world"
    end
    assert_equal("hello, world\n", output)
  end

  def test_web_mode
    $runtime_mode = Heel::Util::RUNTIME_WEB
    assert_equal(true, Heel::Util.web_mode?)
  end

  def test_console_mode
    $runtime_mode = Heel::Util::RUNTIME_CONSOLE
    assert_equal(true, Heel::Util.console_mode?)
  end
end