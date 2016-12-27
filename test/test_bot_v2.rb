require "helper"

class TestBotV2 < Minitest::Test
  context "test dsl" do
    should "" do
      filename = "heelspec/hello_v2".freeze
      code = File.read(filename)
      puts code
    end
  end
end