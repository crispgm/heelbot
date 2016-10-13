Heel::BotV2.define do |bot|
  bot.name   "Hello V2" 
  bot.author "David Zhang"

  bot.trigger "!hv2" do |params|
    bot.implement
  end

  bot.implement do
    puts "hello, v2!"
  end
end