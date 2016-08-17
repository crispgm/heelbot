#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), *%w(.. lib)))

require "heel"

server = Heel::Server.new([])
server.serve