module RSA
  module Prime
    # Sieve of eratosthenes
    def self.sieve_upto(limit)
      nums = [nil, nil, *(2..limit)]
      nums.each do |n|
        next unless n
        break if n ** 2 > limit
        (n**2).step(limit, n) { |i| nums[i] = nil }
      end
      nums.compact
    end
    
    # Given a prime candidate, this will test [iterations] times if the
    # number shares a greatest common denominator other than 1 or if the
    # modular exponent of a random number < 2 < p - 1 is something other
    # than 1. 20 iterations is usually a safe bet: 1/(2 ** 20 iterations)
    def self.fermat_prime?(p, iterations = 50)
      return true if p == 2
      return false if p <= 1
      is_prime = true
      (@small_primes ||= sieve_upto(512)).each do |prime|
        return false if p % prime == 0
      end
      iterations.times do
        a = rand(2..p-1) || 2
        if a.gcd(p) != 1 || Math.mod_exp(a,p-1,p) != 1
          is_prime = false
          break
        end
      end
      is_prime
    end
    
    # Generate random numbers of length within given range then test
    # for primality based on fermat's primality test
    # Note: this number is a BigInt
    def self.get_large_prime(digits = 617)
      guesses = 0
      begin
        num = ""
        digits.times { num += rand(0..9).to_s }
        num = num.to_i
        guesses += 1
        yield guesses if block_given?
      end until fermat_prime?(num)
      num
    end
  end
end
