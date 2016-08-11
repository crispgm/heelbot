require_relative "helper"

class TestCommand < Minitest::Test
  def setup
    argv = ['param1', 'param2', 'param3']
    @cmd = Heel::Command.new(argv)
  end

  def test_init
    argv = ['param1', 'param2', 'param3']
    assert_equal(@cmd.argv.size, argv.size)
  end

  def test_usage
    description = <<DESC
Heelbot Usage:

Version
    heel --version

Bot
    heel list
    heel help [bot_name]
    heel run  [bot_name]
    heel info [bot_name]

DESC
    assert_output(description) {
      @cmd.usage
    }
  end
end