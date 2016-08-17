module Heel
  module Util

    RUNTIME_CONSOLE = 1
    RUNTIME_WEB     = 2
    
    def self.capture_stdout
      begin
        # The output stream must be an IO-like object. In this case we capture it in
        # an in-memory IO object so we can return the string value. You can assign any
        # IO object here.
        previous_stdout, $stdout = $stdout, StringIO.new
        yield
        $stdout.string
      ensure
        # Restore the previous value of stdout (typically equal to STDOUT).
        $stdout = previous_stdout
      end
    end

    def self.web_mode?
      return true if $runtime_mode == RUNTIME_WEB
      false
    end

    def self.console_mode?
      return true if $runtime_mode == RUNTIME_CONSOLE
      false
    end
  end
end