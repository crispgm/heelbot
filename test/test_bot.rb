require "helper"
require_relative "../heelspec/hello_world"

class TestBot < Minitest::Test
  def setup
    @bot = Heelspec::HelloWorld.new
  end

  def test_init
    assert_equal("Hello World", @bot.name)
    assert_equal("1.0.0", @bot.version)
    assert_equal("Print Hello World", @bot.summary)
    assert_equal("David Zhang", @bot.author)
    assert_equal("MIT", @bot.license)
    assert_equal("", @bot.helptext)
    assert_equal(["!hw", "!helloworld"], @bot.triggers)
  end

  def test_get_param
    cmd = nil
    assert_output("Error: Cannot get param #0\n") {
      assert_equal(nil, @bot.get_param(cmd, 0))
    }
    cmd = ["aaa"]
    assert_equal(cmd[0], @bot.get_param(cmd, 0))
  end

  def test_run
    assert_output("hello, world\n") {
      @bot.run(['hello, world'])
    }
  end
end