require "helper"

class TestBotManager < Minitest::Test
  context "test bot manager" do
    setup do
      @bot_manager = Heel::BotManager.new("test/heelspec")
    end

    should "init with bots info" do
      assert_equal("test/heelspec", @bot_manager.spec_path)
      assert_equal("test/heelspec/bots.yml", @bot_manager.conf_path)
      assert_equal("../../test/heelspec", @bot_manager.bots_path)
      assert_equal(2, @bot_manager.bot_list.size)
      assert_equal("hello", @bot_manager.bot_list[0]["Name"])
      assert_equal("test_bot", @bot_manager.bot_list[1]["Name"])
      assert_equal(false, @bot_manager.triggers_loaded)
    end

    should "output error when init inexisted bot" do
      assert_output("inexisted_bot not found\n") {
        @bot_manager.init_bot("inexisted_bot")
      }
    end

    should "init bot" do
      @bot_manager.init_bot("hello")
      assert_equal(true, @bot_manager.bot_instance["hello"].is_a?(Heel::BotV2::DSL))
    end

    should "init without default name" do
      spec_path = "test/emptyspec"
      @bot_manager_without_default_name = Heel::BotManager.new(spec_path)
      assert_equal(spec_path, @bot_manager_without_default_name.spec_path)
      assert_equal([], @bot_manager_without_default_name.bot_list)
      Heel::Shell.sh "rm #{spec_path}/bots.yml"
    end
  end
end