require "helper"
require_relative "../heelspec/rio_2016"

class TestSpecRio < Minitest::Test
  context "heelspec of aqi" do
    setup do
      @klass = Heelspec::Rio2016.new
    end

    should "initialize with properties" do
      assert_equal("Medal Count of RIO 2016 Olympic Games", @klass.name)
    end

    should "Rank\tCode\tGold\tSilver\tBronze\tTotal\tCountry" do
      output_prefix = ""
      output = Heel::Util.capture_stdout do
        @klass.run([])
      end
      assert_equal(true, output.start_with?(output_prefix))
    end
  end
end