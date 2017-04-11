#!/usr/bin/env ruby

require 'prime'

limit = ARGV[0].to_i
2.upto(limit) { |n| $stdout.puts n if n.prime? }
