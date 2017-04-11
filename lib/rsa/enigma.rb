module RSA
  class Enigma
    require 'thread'
    
    attr_reader :prime_one, :prime_two, :semi_prime, :totient_semi_prime, :public_key, :private_key
    
    def initialize(key_size = 128)
      diff = rand(0..10) # Create a random difference in prime sizes
      puts "Generating 2 primes of length #{key_size}"
      
      @prime_one, @prime_two = nil, nil
      p1_g = 0
      p2_g = 0
      Thread.new do
        @prime_one = Prime.get_large_prime(key_size - diff) { |g| p1_g = g }
        puts "Found P1"
      end
      Thread.new do
        @prime_two = Prime.get_large_prime(key_size - diff) { |g| p2_g = g }
        puts "Found P2"
      end

      spinner = %w[- \\ | / - \\ | /]
      print "\rp1: #{p1_g}, p2: #{p2_g} #{spinner.push(spinner.shift)[0]}" until @prime_one && @prime_two
      
      # Semi-prime is a composite with only 2 prime factors
      puts "\nCalculating semi-prime"
      @semi_prime = @prime_one * @prime_two
    
      # Totient of n (hard without knowing p & q)
      puts "Calculating phi of semi-prime"
      @totient_semi_prime = (@prime_one - 1) * (@prime_two - 1)
    
      # random prime with gcd of 1 with tn less than tn
      puts "Generating public key"
      @public_key = nil
      Thread.new { @public_key = gen_pub_key(@totient_semi_prime) }
      wait = 0
      print "\rTry: #{wait += 1}".rjust(10) until @public_key
    
      # multiplicitive inverse of e (mod tn) => (e * d) % tn == 1
      puts "\nCalculating private key"
      @private_key = Math.modular_multiplicative_inverse(@public_key, @totient_semi_prime)
      puts
    end
  
    # Accepts tn (totient of the product of 2 large primes: p & q)
    # Returns a random odd number that only shares a greatest common
    # denominator of 1 with tn.
    def gen_pub_key(tn)
      begin
        pub = rand(3..tn)
        # end until Prime.fermat_prime?(pub) && pub.gcd(tn) == 1
      end until pub % 2 != 0 && pub.gcd(tn) == 1
      pub
    end
  
    def info(base = 36)
      puts <<-INFO.gsub(/^ +/m, '')
      ------------------------------
      Encryption details:
      p:
      #{@prime_one.to_s(base)}
      
      q:
      #{@prime_two.to_s(base)}

      Semi-prime:
      #{@semi_prime.to_s(base)}

      Phi(semi-prime):
      #{@totient_semi_prime.to_s(base)}

      Public Key:
      #{@public_key.to_s(base)}
      
      Private Key:
      #{@private_key.to_s(base)}
      ------------------------------
      INFO
    end
    
    def encrypt(message)
      message = Ascii.str_to_num(message)
      throw "Message cannot be longer than modulus" if message > @semi_prime - 1
      Math.mod_exp(message, @public_key, @semi_prime)
    end
  
    def decrypt(message)
      Ascii.num_to_str Math.mod_exp(message, @private_key, @semi_prime)
    end
  end
end
