require "helper"

class TestBotManager < Minitest::Test
  def setup
    @bot_manager = Heel::BotManager.new("test/heelspec")
  end

  def test_init
    assert_equal("test/heelspec", @bot_manager.spec_path)
    assert_equal("test/heelspec/bots.yml", @bot_manager.conf_path)
    assert_equal("../../test/heelspec", @bot_manager.bots_path)
    assert_equal(2, @bot_manager.bot_list.size)
    assert_equal("hello_world", @bot_manager.bot_list[0]["Name"])
    assert_equal("test_bot", @bot_manager.bot_list[1]["Name"])
    assert_equal(false, @bot_manager.triggers_loaded)
  end

  def test_init_nil_bot
    assert_output("inexisted_bot not found\n") {
      @bot_manager.init_bot("inexisted_bot")
    }
  end

  def test_init_bot
    @bot_manager.init_bot("hello_world")
    assert_equal(true, @bot_manager.bot_instance["hello_world"].is_a?(Heel::Bot))
  end

  def test_init_without_default_name
    spec_path = "test/emptyspec"
    @bot_manager_without_default_name = Heel::BotManager.new(spec_path)
    assert_equal(spec_path, @bot_manager_without_default_name.spec_path)
    assert_equal([], @bot_manager_without_default_name.bot_list)
    Heel::Shell.sh "rm #{spec_path}/bots.yml"
  end

  def test_trigger_bot
    assert_output("Conflict: Trigger !hw is existed.\nhello\n") {
      $runtime_mode = Heel::Util::RUNTIME_CONSOLE
      triggered_name = @bot_manager.trigger_bot("!helloworld hello", {})
      assert_equal(["hello_world", ""], triggered_name)
      assert_equal(false, @bot_manager.triggers_loaded)
    }
  end

  def test_trigger_not_match
    assert_output(nil) {
      $runtime_mode = Heel::Util::RUNTIME_CONSOLE
      triggered_name = @bot_manager.trigger_bot("!aaa", {})
      assert_equal([nil, nil], triggered_name)
    }
  end

  def test_run_bot
    assert_output("hello, world\n") {
      @bot_manager.run_bot("hello_world", ["hello, world"])
    }
  end

  def test_help_bot
    assert_output("\n") {
      @bot_manager.help_bot("hello_world")
    }
  end

  def test_info_bot
    bot_info = <<INFO
Name:     Hello World
Version:  1.0.0
Summary:  Print Hello World
Author:   David Zhang
License:  MIT
Helptext: 
Triggers: !hw, !helloworld
INFO
    assert_output(bot_info) {
      @bot_manager.info_bot("hello_world")
    }
  end
end