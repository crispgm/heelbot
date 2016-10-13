module Heel
  module BotV2

    attr_accessor :trigger, :block

    class Trigger
      def initialize(trigger, block)
        @trigger = trigger
        @block = block
      end

      def trigger(params)
        @block.call(params)
      end
    end
  end
end
