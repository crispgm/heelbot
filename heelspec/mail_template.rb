module Heelspec
  class MailTemplate < Heel::Bot

    require "liquid"

    def initialize
      @name = "Mail Template Generator"
      @version = "2.0.0"
      @summary  = "Generate email with group members and Liquid template"
      @author   = "David Zhang"
      @license  = "MIT"
      @helptext = "mail_template group_name template_name"
      @triggers = ["!mt"]
    end

    def run(cmd)
      if cmd.length == 0
        puts "Error: nil template name"
        return
      end

      template_name = get_param(cmd, 0)

      if !build_vars(template_name)
        puts "Error: build vars failed"
        return
      end

      # build mail
      @mail = Heel::MailHelper.new
      @mail.add_to_raw! @to_people
      @mail.add_cc_raw! @cc_people
      @mail.subject = @subject
      @mail.body = @body

      mail_to = @mail.build_as_mailto
      puts mail_to
      if Heel::Util.console_mode?
        Heel::Shell.open "\"#{mail_to}\""
      end
    end

    private

    def read_yml(template_name)
      yml_path = "heelspec/mail_template/#{template_name}.yml"

      if File.exist? yml_path
        @template_data = YAML.load_file yml_path
      end
    end

    def build_vars(template_name)
      begin
        read_yml(template_name)
      rescue
        puts "Error: read yml failed"
        return
      end

      Liquid::Template.register_tag('group_members', GroupMembersTag)

      @created_time = Time.now

      @template  = Liquid::Template.parse(@template_data["to"])
      @to_people = @template.render("created_time" => "#{@created_time}")
      @template  = Liquid::Template.parse(@template_data["cc"])
      @cc_people = @template.render("created_time" => "#{@created_time}")
      @template  = Liquid::Template.parse(@template_data["title"])
      @subject   = @template.render("created_time" => "#{@created_time}")
      @template  = Liquid::Template.parse(@template_data["body"])
      @body      = @template.render("created_time" => "#{@created_time}")

      true
    end
  end

  class GroupMembersTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      params = text.strip.split(" ")
      @group_name = params[0]
      @group_role = params[1]
    end

    # rubocop:disable Lint/UnusedMethodArgument
    def render(context)
      # call GroupMembers
      require_relative "./group_members"
      gm = GroupMembers.new
      info = gm.get_group(@group_name)

      if info == false
        puts "Error: Group #{@text} is not existed"
        false
      end

      role_symbol = @group_role.to_sym
      output = info[role_symbol].join "@baidu.com;"
      (output << "@baidu.com")
    end
  end
end
