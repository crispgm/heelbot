module Heelspec
  class Iciba < Heel::Bot

    require "open-uri"
    require "CGI"
    require "rexml/document"

    API_KEY = "F80B8F286E263D59F84CCE5FEB6F92C3".freeze
    API_URL = "http://dict-co.iciba.com/api/dictionary.php".freeze

    def initialize
      @name     = "Iciba Dictionary"
      @version  = "1.0.0"
      @summary  = "Query online ICIBA for you"
      @author   = "David Zhang"
      @license  = "MIT"
      @helptext = "iciba WORD\t\tQuery WORD\niciba WORD --say\tQuery and say WORD"
      @triggers = ["!iciba"]
    end

    def run(cmd)
      word = get_param(cmd, 0)
      if word == nil
        exit 1
      end
      body = query(word)
      spell_flag = false
      if cmd[1] != nil && cmd[1].eql?("--say")
        spell_flag = true
      end
      parse(body)

      if spell_flag
        Heel::Shell.sh "say #{cmd[0]}"
      end
    end

    private

    def query(word)
      q = "#{API_URL}?key=#{API_KEY}&w=#{CGI.escape(word)}"

      open q do |http|
        http.read
      end
    end

    def parse(body)
      begin
        doc = REXML::Document.new body
        doc.elements.each("dict/key") do |element|
          puts "Query: #{element.text}"
        end
        doc.elements.each("dict/fy") do |element|
          puts "#{element.text}"
        end
        print "Phonetic Symbols: "
        doc.elements.each("dict/ps") do |element|
          print "|#{element.text}|"
        end
        print "\n"
        doc.elements.each("dict/acceptation") do |element|
          puts "#{element.text}"
        end
      rescue
        puts "XML Parse Error."
        exit(1)
      end
    end
  end
end
