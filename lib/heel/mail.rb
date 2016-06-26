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

    def attachfile!(filenames)
    end

    def build_as_mailto
      mailto = "mailto:#{@to}?cc=#{@cc}&subject=#{@subject}&body=#{@body}"
      mailto
    end
  end
end