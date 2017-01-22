module Heel
  module DSL
    class Implement < Bot
      attr_reader :block

      def initialize(&block)
        @block = block
      end
    end
  end
end
