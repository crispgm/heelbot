module Heel
  class Registry
    def self.register_trigger(text, klass)
      @@klass = klass
    end

    def self.trigger
      @@klass.trigger(nil)
    end
  end
end