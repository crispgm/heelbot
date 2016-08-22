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

    should "show nothing or raise error on non-mac system in console mode" do
      require "os"
      $runtime_mode = Heel::Util::RUNTIME_CONSOLE

      if OS.mac?
        assert_output nil do
          @klass.run([])
        end
      else
        assert_raises Heel::ShellOpenError do
          @klass.run([])
        end
      end
    end

    should "show output in web mode" do
      require "os"
      $runtime_mode = Heel::Util::RUNTIME_WEB

      output = "Schedule: #{Heelspec::Eurocup2016::SCHEDULE_URL}, Result: #{Heelspec::Eurocup2016::RESULT_URL}\n"
      assert_output output do
        @klass.run([])
      end
    end
  end
end