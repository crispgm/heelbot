require "helper"

class TestDsl < Minitest::Test
  context "test dsl" do
    should "load bot info" do
      filename = "heelspec/hello.bot".freeze
      code = File.read(filename)
      
      bot = Heel::BotV2::DSL.new do
        define_attr("name", "version", "author", "summary", "helptext", "license")
        instance_eval(code)
      end

      assert_equal("Hello v2", bot.name)
      assert_equal("2.0.0", bot.version)
      assert_equal("David Zhang", bot.author)
      assert_equal("Hello World v2", bot.summary)
      assert_equal("Hello World v2", bot.helptext)
      assert_equal("MIT", bot.license)
    end
  end
end