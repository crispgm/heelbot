require_relative "helper"
require_relative "../heelspec/hello_world"

class TestMail < Minitest::Test
  def setup
    @bot = Heelspec::HelloWorld.new
  end

  def test_init
    assert_equal("Hello World", @bot.bot_name)
    assert_equal("1.0.0", @bot.bot_version)
    assert_equal("Print Hello World", @bot.bot_summary)
    assert_equal("David Zhang", @bot.bot_author)
    assert_equal("MIT", @bot.bot_license)
    assert_equal("", @bot.bot_helptext)
  end

  def test_get_param
    cmd = nil
    assert_output("Error: Cannot get param #0\n") {
      assert_equal(nil, @bot.get_param(cmd, 0))
    }
    cmd = ["aaa"]
    assert_equal(cmd[0], @bot.get_param(cmd, 0))
  end
end