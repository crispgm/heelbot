require "helper"

class TestDsl < Minitest::Test
  context "test dsl" do
    setup do
      filename = "test/heelspec/hello.bot".freeze
      code = File.read(filename)
      
      @bot = Heel::DSL::Bot.new do
        define_attr("name", "version", "author", "summary", "helptext", "license")
        instance_eval(code)
      end
    end

    should "load bot info" do
      assert_equal("Hello v2", @bot.name)
      assert_equal("2.0.0", @bot.version)
      assert_equal("David Zhang", @bot.author)
      assert_equal("Hello World v2", @bot.summary)
      assert_equal("Hello World v2", @bot.helptext)
      assert_equal("MIT", @bot.license)
    end

    should "implement bot" do
      assert_output("hello, v2!\n") do
        @bot.implementation.block.call
      end
    end

    should "register triggers" do
      assert_equal(["hv1", "hv2"], @bot.triggers.keys)
    end
  end
end
