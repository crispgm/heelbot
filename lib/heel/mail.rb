module Heel
  class MailHelper
    require "mail"

    attr_accessor :from, :to, :cc, :subject, :body, :attachments

    def initialize
      @mail = Mail.new
      @from = ""
      @to = ""
      @cc = ""
      @subject = ""
      @body = ""
      @attachments = ""
    end

    def build_html_body
    end

    def add_to!(ary_names, postfix)
      ary_names.each do |name|
        name <<  postfix << ";"
        @to << name
      end
    end
  end
end