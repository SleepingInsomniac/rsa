module RSA
  module Ascii
    # Convert a string to each character's ascii encoded values 8 bits
    def self.str_to_num(str)
      num = []
      str.each_byte do |c|
        num << c.to_s(2).rjust(8, '0')
      end
      num.join.to_i(2)
    end

    # Convert a number back to ascii
    def self.num_to_str(num)
      num = num.to_s(2)
      num = "0" << num until num.length % 8 == 0
      str = ""
      num.chars.each_slice(8) do |ascii|
        str << ascii.join.to_i(2).chr
      end
      str
    end

    def self.str_to_block(str, width = 64)
      str.chars.each_slice(width).map { |slice|
        slice.join
      }.join("\n")
    end
  end
end
