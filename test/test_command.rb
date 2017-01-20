require "helper"

class TestCommand < Minitest::Test
  
  context "test command" do
    setup do
      @options = {
        :spec_path => "test/heelspec",
        :tpl_path  => "bot_template/bot.liquid"
      }
    end

    should "init with default options" do
      cmd = Heel::Command.new("")
      assert_equal(Heel::Command::DEFAULT_SPEC_PATH, cmd.spec_path)
      assert_equal(Heel::Command::DEFAULT_TEMPLATE_PATH, cmd.tpl_path)
    end

    should "init with partial options and merged with default" do
      cmd1 = Heel::Command.new("", {:spec_path => @options[:spec_path]})
      assert_equal(@options[:spec_path], cmd1.spec_path)
      assert_equal(Heel::Command::DEFAULT_TEMPLATE_PATH, cmd1.tpl_path)

      cmd2 = Heel::Command.new("", {:tpl_path => @options[:tpl_path]})
      assert_equal(Heel::Command::DEFAULT_SPEC_PATH, cmd2.spec_path)
      assert_equal(@options[:tpl_path], cmd2.tpl_path)
    end

    should "init with argv" do
      argv = ["param1", "param2", "param3"]
      cmd = Heel::Command.new(argv, @options)
      assert_equal(argv.size, cmd.argv.size)
      assert_equal(@options[:spec_path], cmd.spec_path)
      assert_equal(@options[:tpl_path], cmd.tpl_path)
    end

    should "show usage" do
      argv = ["param1", "param2", "param3"]
      cmd = Heel::Command.new(argv, @options)
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
        assert_equal("usage", cmd.parse_cmd)
      }
    end

    context "list command" do
      should "list test bot" do
        argv = ["list"]
        cmd = Heel::Command.new(argv, @options)
        output = <<OUT
hello
test
OUT
        assert_output(output) {
          assert_equal("list", cmd.parse_cmd)
        }
      end
    end

    context "run command" do
      should "run bot" do
        argv = ["run", "hello_world", "hello, world"]
        cmd = Heel::Command.new(argv, @options)
        assert_equal("run", cmd.parse_cmd)
      end

      should "invoke usage wihout enough params" do
        argv = ["run"]
        cmd = Heel::Command.new(argv, @options)
        assert_equal("usage", cmd.parse_cmd)
      end
    end

    context "info command" do
      should "info bot" do
        argv = ["info", "hello_world"]
        cmd = Heel::Command.new(argv, @options)
        assert_equal("info", cmd.parse_cmd)
      end

      should "invoke usage wihout enough params" do
        argv = ["info"]
        cmd = Heel::Command.new(argv, @options)
        assert_equal("usage", cmd.parse_cmd)
      end
    end

    context "help command" do
      should "help bot" do
        argv = ["help", "hello_world"]
        cmd = Heel::Command.new(argv, @options)
        assert_equal("help", cmd.parse_cmd)
      end

      should "invoke usage wihout enough params" do
        argv = ["help"]
        cmd = Heel::Command.new(argv, @options)
        assert_equal("usage", cmd.parse_cmd)
      end
    end

    context "new bot command" do
      should "generate new bot" do
        argv = ["new", "test_new_command"]
        cmd = Heel::Command.new(argv, {:spec_path => "test/heelspec"})
        assert_equal("new", cmd.parse_cmd)
        assert_equal(true, File.exist?("test/heelspec/test_new_command.bot"))
        Heel::Shell.sh "rm test/heelspec/test_new_command.bot"
      end

      should "invoke usage wihout enough params" do
        argv = ["new"]
        cmd = Heel::Command.new(argv, @options)
        assert_equal("usage", cmd.parse_cmd)
      end
    end

    context "msg command" do
      context "runtime mode" do
        setup do
          $runtime_mode = Heel::Util::RUNTIME_CONSOLE
        end

        should "invoke with trigger" do
          argv = ["msg", "hv1"]
          cmd = Heel::Command.new(argv, @options)
          assert_equal("msg, [\"hello\", \"\"]", cmd.parse_cmd)
        end

        should "trigger other keyword" do
          argv = ["msg", "hv2"]
          cmd = Heel::Command.new(argv, @options)
          assert_equal("msg, [\"hello\", \"\"]", cmd.parse_cmd)
        end

        should "trigger not exists" do
          argv = ["msg", "aaa"]
          cmd = Heel::Command.new(argv, @options)
          assert_equal("msg, [nil, nil]", cmd.parse_cmd)
        end
      end
      
      # context "web mode" do
      #   should "return bot not implemented when trigger bot without web mode" do
      #     $runtime_mode = Heel::Util::RUNTIME_WEB
      #     argv = ["msg", "!hw", "helloworld"]
      #     cmd = Heel::Command.new(argv, @options)
      #     assert_equal("msg, [nil, nil]", cmd.parse_cmd)
      #   end

      #   should "invoke with trigger" do
      #     $runtime_mode = Heel::Util::RUNTIME_WEB
      #     argv = ["msg", "hv1"]
      #     cmd = Heel::Command.new(argv, @options)
      #     assert_equal("msg, [\"hello\", \"\"]", cmd.parse_cmd)
      #   end
      # end
    end
  end
end