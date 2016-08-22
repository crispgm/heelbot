require "helper"

class TestCommand < Minitest::Test
  
  def setup
    @spec_path = "test/heelspec"
  end

  def test_init
    argv = ['param1', 'param2', 'param3']
    @cmd = Heel::Command.new(argv, @spec_path)
    assert_equal(@cmd.argv.size, argv.size)
  end

  def test_parse_list
    argv = ['list']
    @cmd = Heel::Command.new(argv, @spec_path)
    output = <<OUT
hello_world
test_bot
OUT
    assert_output(output) {
      assert_equal("list", @cmd.parse_cmd)
    }
  end

  def test_parse_msg
    argv = ['msg', '!hw', 'helloworld']
    @cmd = Heel::Command.new(argv, @spec_path)
    assert_equal("msg, test_bot", @cmd.parse_cmd)
  end

  def test_parse_msg2
    argv = ['msg', '!helloworld', 'helloworld']
    @cmd = Heel::Command.new(argv, @spec_path)
    assert_equal("msg, hello_world", @cmd.parse_cmd)
  end

  def test_parse_info
    argv = ['info', 'hello_world']
    @cmd = Heel::Command.new(argv, @spec_path)
    assert_equal("info", @cmd.parse_cmd)
  end

  def test_parse_run
    argv = ['run', 'hello_world', 'hello, world']
    @cmd = Heel::Command.new(argv, @spec_path)
    assert_equal("run", @cmd.parse_cmd)
  end

  def test_parse_help
    argv = ['help', 'hello_world']
    @cmd = Heel::Command.new(argv, @spec_path)
    assert_equal("help", @cmd.parse_cmd)
  end

  def test_parse_usage
    argv = ['param1', 'param2', 'param3']
    @cmd = Heel::Command.new(argv, @spec_path)
    description = <<DESC
Heelbot Usage:

Version
    heel --version

Bot
    heel list
    heel msg  [trigger_msg]
    heel help [bot_name]
    heel run  [bot_name]
    heel info [bot_name]

DESC
    assert_output(description) {
      assert_equal("usage", @cmd.parse_cmd)
    }
  end

  def test_parse_info_with_less_param
    argv = ['info']
    @cmd = Heel::Command.new(argv, @spec_path)
    assert_equal("usage", @cmd.parse_cmd)
  end

  def test_parse_run_with_less_param
    argv = ['run']
    @cmd = Heel::Command.new(argv, @spec_path)
    assert_equal("usage", @cmd.parse_cmd)
  end

  def test_parse_help_with_less_param
    argv = ['help']
    @cmd = Heel::Command.new(argv, @spec_path)
    assert_equal("usage", @cmd.parse_cmd)
  end
end