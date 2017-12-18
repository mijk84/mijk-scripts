#!/usr/bin/ruby
require 'rss'
require 'httparty'

url = ARGV.first

response = HTTParty.get "https://showrss.info/show/#{url}.rss"

feed = RSS::Parser.parse response.body

feed.items.each do |item|
  puts "#{item.title}"
  puts "#{item.link}"
  puts item.description
end
