module Heelspec
  class MailTemplate < Heel::Bot
    def initialize
      @bot_name = "Mail Template Generator"
      @bot_version = "1.0.0"
    end

    def run(cmd)
      # call GroupMembers
      require_relative "./group_members"
      gm = GroupMembers.new

      if cmd.length == 0
        puts "Error: Nil group name"
        return
      end

      info = gm.get_group cmd[0]
      # build mail
      @mail = Heel::MailHelper.new
      to_people = info[:members]
      cc_people = info[:managers]
      # for testing
      cur_date = Time.now.strftime("%Y%m%d")
      subject = "研发一体化日报 #{cur_date}"
      body = "\n===\n张皖龙"

      @mail.add_to!(to_people, "@baidu.com")
      @mail.add_cc!(cc_people, "@baidu.com")
      @mail.subject = subject
      @mail.body = body

      mail_to = @mail.build_as_mailto
      Heel::Shell.open "\"#{mail_to}\""

    end
  end
end