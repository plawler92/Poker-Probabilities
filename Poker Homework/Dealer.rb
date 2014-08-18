require_relative "Deck.rb"
require_relative "Card.rb"

class Dealer

	def initialize(card1, card2)
		#@players = num_players
		@deck = Deck.new
		@hand = []
		@hand << Card.new(card1[0],card1[1])
		@hand << Card.new(card2[0],card2[1])
		@community_cards = []
		@flop_sim_results = {"high_card"=>0.0,
			"pair" =>0.0,
			"two_pair"=>0.0,
			"three_kind"=>0.0,
			"straight"=>0.0,
			"flush"=>0.0,
			"full_house"=>0.0,
			"four_kind"=>0.0,
			"straight_flush"=>0.0}
		@river_sim_results = {"high_card"=>0.0,
			"pair"=>0.0,
			"two_pair"=>0.0,
			"three_kind"=>0.0,
			"straight"=>0.0,
			"flush"=>0.0,
			"full_house"=>0.0,
			"four_kind"=>0.0,
			"straight_flush"=>0.0}
		@turn_sim_results = {"high_card"=>0.0,
			"pair" =>0.0,
			"two_pair"=>0.0,
			"three_kind"=>0.0,
			"straight"=>0.0,
			"flush"=>0.0,
			"full_house"=>0.0,
			"four_kind"=>0.0,
			"straight_flush"=>0.0}
	end

	#working
	def printDeck
		@deck.print
	end

	def get_flop_results
		@flop_sim_results.each do |x,y|
			@flop_sim_results[x] = y/100000
		end
		return @flop_sim_results
	end

	def get_river_results
		@river_sim_results.each do |x,y|
			@river_sim_results[x] = y/100000
		end
		return @river_sim_results
	end

	def get_turn_results
		@turn_sim_results.each do |x,y|
			@turn_sim_results[x] = y/100000
		end
		return @turn_sim_results
	end

	#working
	def deal_hand(num_cards)
		num_cards.times do
			@hand << @deck.deal
		end
	end

	def run_simulation
		100000.times do
			shuffle_deck
			deal_community_cards(3)
			@flop_sim_results[evaluate_hand] += 1
			deal_community_cards(1)
			@river_sim_results[evaluate_hand] += 1
			deal_community_cards(1)
			@turn_sim_results[evaluate_hand] += 1
			@community_cards = []
		end
	end

	def print_results
		puts @flop_sim_results
		puts @river_sim_results
		puts @turn_sim_results
	end


	def deal_community_cards(num_cards)
		num_cards.times do
			card = @deck.deal
			while (card.get_val.to_i == @hand[0].get_val.to_i && card.get_suit == @hand[0].get_suit) ||
				(card.get_val.to_i == @hand[1].get_val.to_i && card.get_suit == @hand[1].get_suit)
				card = @deck.deal				
			end
			@community_cards << card
		end
	end


	#working
	def shuffle_deck
		@deck.shuffle
	end

	#seems to be working
	def evaluate_hand
		#royal>straight>4>fullhou>flush>straight>3>2pair>2
		#first, get is all 5 same suit
		straight = has_straight
		flush = has_flush
		mult_vals = has_multiple_vals
		if straight && flush
			return "straight_flush"
		elsif mult_vals == "4"
			return "four_kind"
		elsif mult_vals == "3-2"
			return "full_house"
		elsif flush
			return "flush"
		elsif straight
			return "straight"
		elsif mult_vals == "3"
			return "three_kind"
		elsif mult_vals == "2-2"
			return "two_pair"
		elsif mult_vals == "2"
			return "pair"		
		else
			return "high_card"
		end
	end

	#seems to be working
	def has_multiple_vals
		full_hand = []

		@hand.each do|card|
			full_hand << card
		end
		@community_cards.each do|card|
			full_hand << card
		end

		num_vals = Hash.new(0)
		full_hand.each do |card|
			num_vals[card.get_val.to_i] += 1			
		end
		outcomes = [0,0]
		num_vals.each do |x, y|
			if y == 4
				return "4"
			elsif y == 3
				outcomes[1] = 1
			elsif y == 2
				outcomes[0] += 1
			end
		end

		if outcomes[1] == 1 && outcomes[0] == 1
			return "3-2"
		elsif outcomes[1] == 1
			return "3"
		elsif outcomes[0] == 2
			return "2-2"
		elsif outcomes[0] == 1
			return "2"
		end
		return"0"		
	end

	#seems to be working correctly
	def has_flush
		full_hand = []

		@hand.each do|card|
			full_hand << card
		end
		@community_cards.each do|card|
			full_hand << card
		end

		num_suits = {"S" =>0,
			"C"=>0,
			"H"=>0,
			"D"=>0}
		full_hand.each do |card|
			num_suits[card.get_suit] += 1
		end

		num_suits.each do |x, y|
			if y == 5
				return true
			end
		end
		return false
	end
	
	#seems to be working correctly
	def has_straight
		full_hand = []

		@hand.each do|card|
			full_hand << card
		end
		@community_cards.each do|card|
			full_hand << card
		end

		vals = []
		full_hand.each do |card|
			vals << card.get_val.to_i
		end
		vals.sort!
		vals = vals.uniq

		if vals[-1] == 14 && vals[0] == 2 &&  vals[1] == 3 && vals[2] == 4 && vals[3] == 5
			return true
		else
			for i in 1..vals.length do
				if vals[i] != vals[i-1] + 1
					return false
				end
			end
		end
		
		return true
	end

	def print_hand		
		@hand.each do |card|
			card.print
		end		
	end	

	def print_community_cards
		@community_cards.each do |card|
			card.print
		end
	end

end










