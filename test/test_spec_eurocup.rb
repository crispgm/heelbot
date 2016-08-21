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

    should "show nothing after running" do
      assert_output(nil) {
        @klass.run([])
      }
    end
  end
end