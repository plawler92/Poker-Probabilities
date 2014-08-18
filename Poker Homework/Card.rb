class Card

	def initialize(val, s)
		if val == "A"
			@value = 14
		elsif val =="K"
			@value = 13
		elsif val == "Q"
			@value = 12
		elsif val == "J"
			@value = 11
		else
			@value = val
		end
		#@value = val #2-14
		@suit = s #S,C,D,H
	end

	def print
		if @value == 11
			puts "J, #{@suit}"
		elsif @value == 12
			puts "Q, #{@suit}"
		elsif @value == 13
			puts "K, #{@suit}"
		elsif @value == 14
			puts "A, #{@suit}"
		else
			puts "#{@value}, #{@suit}"
		end
	end

	def get_val

		return @value
	end

	def get_suit
		return @suit
	end

	def ==(another_card)
		@value == another_card.get_val && @suit == another_card.get_suit

	end
end