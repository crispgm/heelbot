module Heel
  class Mail
    require "mail"

    attr_writer :from, :to, :subject, :body, :attachments,

    def initialize
      @mail = Mail.new
    end

    def build_html_body
    end
  end
end