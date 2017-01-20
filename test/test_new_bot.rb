require "helper"

class TestNewBot < Minitest::Test
  context "test new bot" do
    setup do
      options = {
        :tpl_path  => "lib/bot_template/bot.liquid",
        :spec_path => "test/heelspec"
      }
      @new_bot = Heel::NewBot.new(options)
    end

    should "initialize with paths" do
      assert_equal("lib/bot_template/bot.liquid", @new_bot.tpl_path)
      assert_equal("test/heelspec", @new_bot.spec_path)
    end

    should "generate new bot" do
      bot_info = {
        "name"     => "test_new_bot",
        "version"  => "1.0.0",
        "summary"  => "A new Heel bot.",
        "author"   => "Test",
        "license"  => "MIT",
        "helptext" => "testing new bot",
        "triggers" => ["!new"]
      }
      @new_bot.process(bot_info)
      filename = "test/heelspec/test_new_bot.bot"
      assert_equal(true, File.exist?(filename))

      code = File.read(filename)
      @bot = Heel::DSL::Bot.new do
        define_attr("name", "version", "author", "summary", "helptext", "license")
        instance_eval(code)
      end

      assert_equal(bot_info["name"], @bot.name)
      assert_equal(bot_info["version"], @bot.version)
      assert_equal(bot_info["summary"], @bot.summary)
      assert_equal(bot_info["author"], @bot.author)
      assert_equal(bot_info["license"], @bot.license)
      assert_equal(bot_info["helptext"], @bot.helptext)
      assert_equal(bot_info["triggers"], @bot.triggers.keys)
    end

    should "raise error when bot exists" do
      bot_info = {
        "name"     => "test_bot",
        "version"  => "1.0.0",
        "summary"  => "A new Heel bot.",
        "author"   => "Test",
        "license"  => "MIT",
        "helptext" => "testing new bot",
        "triggers" => ["!new"]
      }
      exception = assert_raises Heel::BotExistedError do
        @new_bot.process(bot_info)
      end
      assert_equal("Bot test_bot is existed.", exception.message)
    end

    teardown do
      Heel::Shell.sh "rm test/heelspec/test_new_bot.bot"
    end
  end
end