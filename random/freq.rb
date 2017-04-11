#!/usr/bin/env ruby

input = "the quick brow fox jumps over the lazy dog"

def freq(input, take = 1)
  occurance = Hash.new { 0 }
  input.each_char do |c|
    occurance[c] = occurance[c] + 1
  end
  occurance
end

# input.chars.each_slice(3) do |s|
#   puts s.join
# end

puts freq(input)
