require "helper"
require_relative "../test/heelspec/hello_world"
require_relative "../test/heelspec/test_not_impl"

class TestBot < Minitest::Test
  context "test bot" do
    setup do
      @bot = Heelspec::HelloWorld.new
      @bot_not_impl = Heelspec::TestNotImpl.new
    end

    context "init bot" do
      should "with bot info" do
        assert_equal("Hello World", @bot.name)
        assert_equal("1.0.0", @bot.version)
        assert_equal("Print Hello World", @bot.summary)
        assert_equal("David Zhang", @bot.author)
        assert_equal("MIT", @bot.license)
        assert_equal("", @bot.helptext)
        assert_equal(["!hw", "!helloworld"], @bot.triggers)
      end
    end

    context "bot runtime" do
      context "get params" do
        should "output error when param is nil" do
          cmd = nil
          assert_output("Error: Cannot get param #0\n") {
            assert_equal(nil, @bot.get_param(cmd, 0))
          }
        end

        should "output error when param is empty" do
          cmd = [""]
          assert_output("Error: Cannot get param #0\n") {
            assert_equal(nil, @bot.get_param(cmd, 0))
          }
        end

        should "return param when it is available" do
          cmd = ["aaa"]
          assert_equal(cmd[0], @bot.get_param(cmd, 0))
        end
      end

      context "run but bot not implemented" do
        should "output error bot not implemented" do
          assert_output("Bot not implemented") {
            @bot_not_impl.run([])
          }
        end

        should "return json with bot not implemented" do
          assert_equal({ :text => "Bot not implemented"}, @bot_not_impl.serve(nil))
        end
      end

      context "bot is OK" do
        should "run bot" do
          assert_output("hello, world\n") {
            @bot.run(['hello, world'])
          }
        end

        should "serve bot" do
          assert_equal({ :text => "hello,world" }, @bot.serve(nil))
        end
      end
    end
  end
end