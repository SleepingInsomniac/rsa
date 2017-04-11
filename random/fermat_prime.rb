#!/usr/bin/env ruby

def fermat_prime?(p, iterations = 20)
  return true if p == 2
  return false if p <= 1
  is_prime = true
  iterations.times do
    a = rand(2..p-1) || 2
    if a.gcd(p) != 1 || mod_exp(a,p-1,p) != 1
      is_prime = false
      break
    end
  end
  is_prime
end

def mod_exp(base, exp, mod)
  return 0 if mod == 1
  base = base % mod
  result = 1
  while exp > 0
    if exp % 2 == 1
      result = (result * base) % mod
    end
    exp = exp >> 1
    base = (base * base) % mod
  end
  result
end

def get_large_prime(range = 1024..2048)
  begin
    num = ""
    rand(512..1024).times { num += rand(0..9).to_s }
    num = num.to_i
  end until fermat_prime?(num)
  num
end

# p1 = get_large_prime
# puts p1
# p2 = get_large_prime
# puts p2
#
# c = p1 * p2
# c.to_s(16).chars.each_slice(128) do |slice|
#   puts slice.join
# end

size = 100
1.upto(size*size) do |num|
  # num = rand 2..1000
  if fermat_prime?(num)
    # puts "Prime: #{num}"
    print "*"
  else
    # puts "Comp: #{num}"
    print " "
  end
  puts if num % size == 0
end

