module Heel
  module Shell
    def sh(cmd...)
      system(cmd)
    end

    def open(filename)
      sh "open #{filename}"
    end
  end
end