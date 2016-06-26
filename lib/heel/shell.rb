module Heel
  class Shell
    def self.sh(cmd)
      system(cmd)
    end

    def self.open(filename)
      sh "open #{filename}"
    end
  end
end