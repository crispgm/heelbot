module Heel
  class Shell

    def self.sh(cmd)
      system(cmd)
    end

    def self.open(filename)
      if OS.mac?
        sh "open #{filename}"
      else
        raise ShellOpenError, 'Cannot open in non-mac system'
      end
    end
  end

  class ShellOpenError < StandardError
  end
end
