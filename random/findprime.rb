#!/usr/bin/env ruby

require 'prime'

it_is_prime = false
iterations = 0
until it_is_prime do
  pc = ''
  300.times do
    pc = "#{pc}#{rand(0..9)}"
  end
  pc = pc.to_i
  if pc.prime?
    it_is_prime = true
    puts "\n\n#{pc}"
  else
    print "\r#{iterations}"
  end
  iterations = iterations + 1
end
