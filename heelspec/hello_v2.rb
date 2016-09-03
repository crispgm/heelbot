Heel::BotV2.define do
  name   "Hello V2" 
  author "David Zhang"

  trigger "!hv2" do |params|
    implement
  end

  implement do
    puts "hello, v2!"
  end
end