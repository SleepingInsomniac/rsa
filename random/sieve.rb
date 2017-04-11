#!/usr/bin/env ruby
require 'prime'

def sieve_upto(limit)
  nums = [nil, nil, *(2..limit)]
  nums.each do |n|
    next unless n
    break if n ** 2 > limit
    (n**2).step(limit, n) { |i| nums[i] = nil }
  end
  nums.compact
end

sieve_upto(512)

# limit = 10000
# m = 200
# sieve_upto(limit).each_slice(m).with_index do |x, i|
#   x.each.with_index do |n,j|
#     if i*m + j == n
#       # p n.to_s.rjust(limit.to_s.length)
#       print "*"#.rjust(limit.to_s.length)
#     else
#       # print "#{i*10 + j}".rjust(6)
#       print " "#.rjust(limit.to_s.length, '-')
#     end
#   end
#   puts ""
# end
