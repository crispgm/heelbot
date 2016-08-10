require "minitest/autorun"
require_relative "../lib/heel"

class TestBotManager < Minitest::Test
  def test_init
    @bot_manager = Heel::BotManager.new
    assert_equal(@bot_manager.bot_list.size, 7)
    assert_equal(@bot_manager.bot_list[0]["Name"], "group_members")
    assert_equal(@bot_manager.bot_list[1]["Name"], "mail_template")
    assert_equal(@bot_manager.bot_list[2]["Name"], "eurocup_schedule_2016")
    assert_equal(@bot_manager.bot_list[3]["Name"], "eurocup_results_2016")
    assert_equal(@bot_manager.bot_list[4]["Name"], "iciba")
    assert_equal(@bot_manager.bot_list[5]["Name"], "aqi")
    assert_equal(@bot_manager.bot_list[6]["Name"], "hello_world")
  end
end