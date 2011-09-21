#!/usr/bin/env ruby

require 'cgi'
require 'optparse'
require 'open-uri'
require 'highline/import'

options = {
  :pwd => nil,
  :cmd => "amulecmd",
  :only_list => false,
}
OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [verycd url] ..."

  opts.on("-p", "--password PASSWORD", "Password to login amulecmd") do |p|
    options[:pwd] = p
  end

  opts.on("-c", "--command COMMAND", "The command to run amulecmd, default: amulecmd") do |p|
    options[:cmd] = p
  end

  opts.on("-l", "--only_list", "Only list ed2k uri in given pages.") do
    options[:only_list] = true
  end
end.parse!

if not options[:pwd]
  options[:pwd] = ask("Password: ") { |q| q.echo = false } unless options[:only_list]
end

ARGV.each do |url|
  open(url).read.scan(/<a[^>]*ed2k="([^"]*)"/) do |ed2k|
    out = ""
    out += "add " unless options[:only_list]
    out += "#{CGI.unescape(ed2k[0])}"
    out += `#{options[:cmd]} --password=#{options[:pwd]} --command="add #{ed2k[0]}"` unless options[:only_list]
    puts out
  end
end
