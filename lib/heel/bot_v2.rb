module Heel
  module BotV2

    require "heel/bot_v2/define"
    require "heel/bot_v2/implement"
    require "heel/bot_v2/trigger"

    def self.define
      bot = Heel::BotV2::Define.new
      yield bot
    end

  end
end