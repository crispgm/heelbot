require "helper"

class TestShell < Minitest::Test
  def test_open_fail_in_non_mac_os
    if !OS.mac?
      exception = assert_raises Heel::ShellOpenError do
        Heel::Shell.open('')
      end
      assert_equal('Cannot open in non-mac system', exception.message)
    end
  end
end