require "helper"

class TestCommand < Minitest::Test
  def test_init
    argv = ['param1', 'param2', 'param3']
    @cmd = Heel::Command.new(argv)
    assert_equal(@cmd.argv.size, argv.size)
  end

  def test_parse_list
    argv = ['list']
    @cmd = Heel::Command.new(argv)
    output = <<OUT
group_members
mail_template
eurocup_schedule_2016
eurocup_results_2016
iciba
aqi
hello_world
rio_olympic_medal_count
OUT
    assert_output(output) {
      assert_equal("list", @cmd.parse_cmd)
    }
  end

  def test_parse_info
    argv = ['info', 'hello_world']
    @cmd = Heel::Command.new(argv)
    assert_equal("info", @cmd.parse_cmd)
  end

  def test_parse_run
    argv = ['run', 'hello_world', 'hello, world']
    @cmd = Heel::Command.new(argv)
    assert_equal("run", @cmd.parse_cmd)
  end

  def test_parse_help
    argv = ['help', 'hello_world']
    @cmd = Heel::Command.new(argv)
    assert_equal("help", @cmd.parse_cmd)
  end

  def test_parse_usage
    argv = ['param1', 'param2', 'param3']
    @cmd = Heel::Command.new(argv)
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
      assert_equal("usage", @cmd.parse_cmd)
    }
  end

  def test_parse_info_with_less_param
    argv = ['info']
    @cmd = Heel::Command.new(argv)
    assert_equal("usage", @cmd.parse_cmd)
  end

  def test_parse_run_with_less_param
    argv = ['run']
    @cmd = Heel::Command.new(argv)
    assert_equal("usage", @cmd.parse_cmd)
  end

  def test_parse_help_with_less_param
    argv = ['help']
    @cmd = Heel::Command.new(argv)
    assert_equal("usage", @cmd.parse_cmd)
  end
end