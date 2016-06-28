module Heel
  class MailHelper

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

    def add_cc!(ary_names, postfix)
      ary_names.each do |name|
        name <<  postfix << ";"
        @cc << name
      end
    end

    def attachfile!(filenames)
    end

    def valid?
      if @to.length <=0
        false
      end
      true
    end

    def valid_strict?
      true if valid?
      if @subject.length <= 0
        false
      end
      if @body.length <= 0
        false
      end
      true
    end

    def build_as_mailto
      false if !valid?
      mailto = "mailto:#{@to}?cc=#{@cc}&subject=#{@subject}&body=#{@body}"
      mailto
    end
  end
end