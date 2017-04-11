module RSA
  module Math
    # This is basically b ** e % m. But, those numbers would be massive
    # It's easier to compute using this shortcut
    def self.mod_exp(base, exp, mod)
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
    
    # https://en.wikipedia.org/wiki/Modular_multiplicative_inverse#Computation
    def self.modular_multiplicative_inverse(a, n)
      t = 0; newt = 1
      r = n; newr = a
      while newr != 0
        quotient = r / newr
        t, newt = newt, t - quotient * newt
        r, newr = newr, r - quotient * newr
      end
      throw "a is not invertible" if r > 1
      t = t + n if t < 0
      return t
    end
  end
end
