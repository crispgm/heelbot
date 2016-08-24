#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), *%w(.. lib)))

require "heel"

$runtime_mode = Heel::Util::RUNTIME_WEB

server = Heel::Server.new([])
server.serve