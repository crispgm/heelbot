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
      assert_equal(false, @bot_manager.triggers_loaded)
    end

    should "iterate bots" do
      @bot_manager.each do |bot|
        assert_equal(true, bot["Name"] == "hello" || bot["Name"] == "test")
      end
    end

    should "output error when init inexisted bot" do
      assert_output("inexisted_bot not found\n") {
        @bot_manager.init_bot("inexisted_bot")
      }
    end

    should "init bot" do
      @bot_manager.init_bot("hello")
      assert_equal(true, @bot_manager.bot_instance["hello"].is_a?(Heel::DSL::Bot))
    end

    should "help bot" do
      assert_output("Hello World v2\n") {
        @bot_manager.help_bot("hello")
      }
    end

    should "show bot info" do
      bot_info = <<INFO
Name:     Hello v2
Version:  2.0.0
Summary:  Hello World v2
Author:   David Zhang
License:  MIT
Helptext: Hello World v2
Triggers: hv1, hv2
INFO
      assert_output(bot_info) {
        @bot_manager.info_bot("hello")
      }
    end

    context "trigger bot" do
      should "nil when trigger nil" do
        assert_output(nil) do
          $runtime_mode = Heel::Util::RUNTIME_CONSOLE
          triggered_name = @bot_manager.trigger_bot(nil)
          assert_equal([nil, nil], triggered_name)
        end
      end

      should "match msg" do
        assert_output("hello, v2!\n") do
          $runtime_mode = Heel::Util::RUNTIME_CONSOLE
          triggered_name = @bot_manager.trigger_bot("hv1")
          assert_equal(["hello", ""], triggered_name)
          assert_equal(false, @bot_manager.triggers_loaded)
        end
      end

      should "not match" do
        assert_output(nil) do
          $runtime_mode = Heel::Util::RUNTIME_CONSOLE
          triggered_name = @bot_manager.trigger_bot("aaa")
          assert_equal([nil, nil], triggered_name)
        end
      end
    end

    context "run bot" do
      should "call block" do
        assert_output("hello, v2!\n") {
          @bot_manager.run_bot("hello")
        }
      end
    end
  end

  context "init without default name" do
    should "load bots list" do
      spec_path = "test/emptyspec"
      @bot_manager_without_default_name = Heel::BotManager.new(spec_path)
      assert_equal(spec_path, @bot_manager_without_default_name.spec_path)
      assert_equal([], @bot_manager_without_default_name.bot_list)
      Heel::Shell.sh "rm #{spec_path}/bots.yml"
    end
  end
end