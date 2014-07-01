class Base62

	ALPHABET = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a

	def self.convert62(number)

		unless number.is_a? Fixnum
			raise TypeError.new("argument must be a Fixnum")
		end

		return ALPHABET[0] if number.zero? 

		ret = ""
		until number.zero? do
			ret += ALPHABET[number%62]
			number /= 62
		end
		ret.reverse

	end


	def self.rconvert62(string)
		
		unless string.is_a? String
			raise TypeError.new("argument must be a String")
		end

		unless string.chars.all? { |char| ALPHABET.include? char }
			raise TypeError.new("argument consists of characters out of the valid alphabet")
		end

		indices = string.chars.map { |char| ALPHABET.index(char).to_i }.reverse
		(0...indices.size).reduce(0) do |acc, i|
			acc + 62 ** i * (i+1)
		end

	end


end

			
		

