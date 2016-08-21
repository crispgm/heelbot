require "helper"
require_relative "../heelspec/iciba"

class TestSpecIciba < Minitest::Test
  context "heelspec of iciba" do
    setup do
      @klass = Heelspec::Iciba.new
    end

    should "initialize with properties" do
      assert_equal("Iciba Dictionary", @klass.name)
    end

    should "print error message if no word input" do
      assert_output("Error: Cannot get param #0\nError: no word input\n") {
        @klass.run(nil)
      }
    end

    should "show if english word input" do
      output = <<OUTPUT
Query: hello
Phonetic Symbols: |hə'ləʊ||həˈloʊ|
哈喽，喂；你好，您好；表示问候；打招呼；
“喂”的招呼声或问候声；
喊“喂”；
OUTPUT
      assert_output(output) {
        @klass.run(["hello"])
        assert_equal(false, @klass.spell_flag)
      }
    end

    should "say word with --say" do
      @klass.run(["aa", "--say"])
      assert_equal(true, @klass.spell_flag)
    end
  end
end