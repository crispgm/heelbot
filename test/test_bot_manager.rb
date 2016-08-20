require "helper"

class TestBotManager < Minitest::Test
  def setup
    @bot_manager = Heel::BotManager.new
  end

  def test_init
    assert_equal(@bot_manager.bot_list.size, 8)
    assert_equal(@bot_manager.bot_list[0]["Name"], "group_members")
    assert_equal(@bot_manager.bot_list[1]["Name"], "mail_template")
    assert_equal(@bot_manager.bot_list[2]["Name"], "eurocup_schedule_2016")
    assert_equal(@bot_manager.bot_list[3]["Name"], "eurocup_results_2016")
    assert_equal(@bot_manager.bot_list[4]["Name"], "iciba")
    assert_equal(@bot_manager.bot_list[5]["Name"], "aqi")
    assert_equal(@bot_manager.bot_list[6]["Name"], "hello_world")
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

  def test_trigger_bot
    triggered_name = @bot_manager.trigger_bot("!hw hello", {})
    assert_equal("hello_world", triggered_name)
    assert_equal(false, @bot_manager.triggers_loaded)
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