#!/usr/bin/env crystal

require "big/big_int"

def sieve_upto(n)
  s = [] of BigInt | Nil
  n.times { |x| s << x }
  s[0] = nil
  s[1] = nil
  s.each do |p|
    next unless p
    break if p * p > n - 1
    (p*p).step(n,p) { |m| s[m] = nil if m < n -1 }
  end
  s.compact
end

# def sieve_upto(n)
#   s = (0..n).to_a
#   s.each do |p|
#     next unless p
#     break if p * p > n
#     (p*p).step(n, p) { |m| s[m] = nil }
#   end
#   s.compact
# end

puts sieve_upto BigInt.new(1000)
