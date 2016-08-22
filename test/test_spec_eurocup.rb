require "helper"
require_relative "../heelspec/eurocup_2016"

class TestSpecEurocup < Minitest::Test
  context "heelspec of Euro Cup" do
    setup do
      @klass = Heelspec::Eurocup2016.new
    end

    should "initialize with properties" do
      assert_equal("Euro Cup 2016", @klass.name)
    end

    should "show nothing or raise error on non-mac system" do
      require "os"

      if OS.mac?
        assert_output(nil) {
          @klass.run([])
        }
      else
        assert_raises Heel::ShellOpenError do
          @klass.run([])
        end
      end
    end
  end
end