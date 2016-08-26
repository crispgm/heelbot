require "helper"

class TestCommand < Minitest::Test
  
  context "test command" do
    setup do
      @spec_path = "test/heelspec"
      @tpl_path  = "bot_template/bot.liquid"
    end

    should "init with argv" do
      argv = ["param1", "param2", "param3"]
      @cmd = Heel::Command.new(argv, @spec_path, @tpl_path)
      assert_equal(argv.size, @cmd.argv.size)
      assert_equal(@spec_path, @cmd.spec_path)
      assert_equal(@tpl_path, @cmd.tpl_path)
    end

    should "show usage" do
      argv = ["param1", "param2", "param3"]
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

New Bot
    heel new  [bot_name]

DESC
      assert_output(description) {
        assert_equal("usage", @cmd.parse_cmd)
      }
    end

    context "list command" do
      should "list test bot" do
        argv = ["list"]
        @cmd = Heel::Command.new(argv, @spec_path)
        output = <<OUT
hello_world
test_bot
OUT
        assert_output(output) {
          assert_equal("list", @cmd.parse_cmd)
        }
      end
    end

    context "run command" do
      should "run bot" do
        argv = ["run", "hello_world", "hello, world"]
        @cmd = Heel::Command.new(argv, @spec_path)
        assert_equal("run", @cmd.parse_cmd)
      end

      should "invoke usage wihout enough params" do
        argv = ["run"]
        @cmd = Heel::Command.new(argv, @spec_path)
        assert_equal("usage", @cmd.parse_cmd)
      end
    end

    context "info command" do
      should "info bot" do
        argv = ["info", "hello_world"]
        @cmd = Heel::Command.new(argv, @spec_path)
        assert_equal("info", @cmd.parse_cmd)
      end

      should "invoke usage wihout enough params" do
        argv = ["info"]
        @cmd = Heel::Command.new(argv, @spec_path)
        assert_equal("usage", @cmd.parse_cmd)
      end
    end

    context "help command" do
      should "help bot" do
        argv = ["help", "hello_world"]
        @cmd = Heel::Command.new(argv, @spec_path)
        assert_equal("help", @cmd.parse_cmd)
      end

      should "invoke usage wihout enough params" do
        argv = ["help"]
        @cmd = Heel::Command.new(argv, @spec_path)
        assert_equal("usage", @cmd.parse_cmd)
      end
    end

    context "new bot command" do
      should "generate new bot" do
        argv = ["new", "test_new_command"]
        @cmd = Heel::Command.new(argv, @spec_path)
        assert_equal("new", @cmd.parse_cmd)
        assert_equal(true, File.exist?("test/heelspec/test_new_command.rb"))
        Heel::Shell.sh "rm test/heelspec/test_new_command.rb"
      end

      should "invoke usage wihout enough params" do
        argv = ["new"]
        @cmd = Heel::Command.new(argv, @spec_path)
        assert_equal("usage", @cmd.parse_cmd)
      end
    end

    context "msg command" do
      context "runtime mode" do
        should "invoke with trigger" do
          $runtime_mode = Heel::Util::RUNTIME_CONSOLE
          argv = ["msg", "!hw", "helloworld"]
          @cmd = Heel::Command.new(argv, @spec_path)
          assert_equal("msg, [\"test_bot\", \"\"]", @cmd.parse_cmd)
        end

        should "trigger other keyword" do
          $runtime_mode = Heel::Util::RUNTIME_CONSOLE
          argv = ["msg", "!helloworld", "helloworld"]
          @cmd = Heel::Command.new(argv, @spec_path)
          assert_equal("msg, [\"hello_world\", \"\"]", @cmd.parse_cmd)
        end
      end
      
      context "web mode" do
        should "return bot not implemented when trigger bot without web mode" do
          $runtime_mode = Heel::Util::RUNTIME_WEB
          argv = ["msg", "!hw", "helloworld"]
          @cmd = Heel::Command.new(argv, @spec_path)
          assert_equal("msg, [\"test_bot\", {:text=>\"Bot not implemented\"}]", @cmd.parse_cmd)
        end

        should "invoke with trigger" do
          $runtime_mode = Heel::Util::RUNTIME_WEB
          argv = ["msg", "!helloworld", "helloworld"]
          @cmd = Heel::Command.new(argv, @spec_path)
          assert_equal("msg, [\"hello_world\", {:text=>\"hello,world\"}]", @cmd.parse_cmd)
        end
      end
    end
  end
end