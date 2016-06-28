module Heel
  class Shell
    require "os"

    def self.sh(cmd)
      system(cmd)
    end

    def self.open(filename)
      if OS.mac?
        sh "open #{filename}"
      else
        raise ShellOpenError
      end
    end
  end

  class ShellOpenError < StandardError
  end
end