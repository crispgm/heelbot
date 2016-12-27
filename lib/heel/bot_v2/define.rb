module Heel
  module BotV2
    class Define

      attr_accessor :attributes

      def initialize
        @attributes = {
          :name     => "",
          :version  => "",
          :summary  => "",
          :author   => "",
          :license  => "",
          :helptext => ""
        }
      end

      def trigger(text = "", &block)
        puts "Registered trigger: #{text}"
        Heel::Registry.register_trigger(text, Trigger.new(text, block))
      end

      def implement
        puts "implement"
        if block_given?
          yield
        end
      end

      def method_missing(name, *args, &block)
        if @attributes.has_key?(name)
          if args.size == 0
            @attributes[name.to_sym]
          elsif args.size >= 1
            @attributes[name.to_sym] = args[0]
          end
        end
      end

      def inspect
        "<>"
      end
    end
  end
end