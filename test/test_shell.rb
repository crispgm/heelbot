require "helper"

class TestShell < Minitest::Test
  context "test shell" do
    should "raise exception in non-mac system" do
      if !OS.mac?
        exception = assert_raises Heel::ShellOpenError do
          Heel::Shell.open('')
        end
        assert_equal('Cannot open in non-mac system', exception.message)
      end
    end

    should "call execute shell command" do
      assert_equal(true, Heel::Shell.sh('echo'))
    end
  end
end