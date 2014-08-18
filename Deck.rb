require_relative "Card.rb"
class Deck

	def initialize
		@cards = []		
		for i in 2..14
			["S","C","H","D"].each do |x|
				@cards << Card.new(i,x)
			end
		end
	end

	def shuffle
		@cards.shuffle!
	end

	def deal
		deal_card = @cards[0]
		@cards << @cards[0]
		@cards = @cards.drop(1)
		return deal_card
	end

	def print
		@cards.each do |card|
			card.print
		end
	end
end

