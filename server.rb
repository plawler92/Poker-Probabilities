require 'sinatra'
require 'sinatra/json'
require 'htmlentities'
require 'json'
require_relative 'Dealer.rb'

get '/' do
	

	erb :page
end

post '/test' do
	val = params[:name]
	puts val #puts is putting out the riht value
	return json :name => val
end


post '/test2' do
	#this does the trick
	coder = HTMLEntities.new
	val = params[:card]
	puts coder.encode(val, :named)
	#puts val
	return json :card => val
end

post '/calculate' do
	coder= HTMLEntities.new
	card1 = coder.encode(params[:card1], :named);
	card2 = coder.encode(params[:card2], :named);
	card1 = card1.sub('&hearts;','H')
	card1 = card1.sub('&clubs;','C')
	card1 = card1.sub('&diams;','D')
	card1 = card1.sub('&spades;','S')
	card2 = card2.sub('&hearts;','H')
	card2 = card2.sub('&clubs;','C')
	card2 = card2.sub('&diams;','D')
	card2 = card2.sub('&spades;','S')
	puts card1[0], card1[1]
	dealer = Dealer.new(card1,card2)
	dealer.run_simulation
	flop = dealer.get_flop_results
	river = dealer.get_river_results
	turn = dealer.get_turn_results
	puts flop["pair"]
	puts "heeeey"
	j = {:flop_pair=>flop["pair"].to_s,
		:flop_two_pair=>flop["two_pair"].to_s,
		:flop_three_kind=>flop["three_kind"].to_s,
		:flop_straight=>flop["straight"].to_s,
		:flop_flush=>flop["flush"].to_s,
		:flop_full_house=>flop["full_house"].to_s,
		:flop_four_kind=>flop["four_kind"].to_s,
		:flop_straight_flush=>flop["straight_flush"].to_s,
		:river_pair=>river["pair"].to_s,
		:river_two_pair=>river["two_pair"].to_s,
		:river_three_kind=>river["three_kind"].to_s,
		:river_straight=>river["straight"].to_s,
		:river_flush=>river["flush"].to_s,
		:river_full_house=>river["full_house"].to_s,
		:river_four_kind=>river["four_kind"].to_s,
		:river_straight_flush=>river["straight_flush"].to_s,
		:turn_pair=>turn["pair"].to_s,
		:turn_two_pair=>turn["two_pair"].to_s,
		:turn_three_kind=>turn["three_kind"].to_s,
		:turn_straight=>turn["straight"].to_s,
		:turn_flush=>turn["flush"].to_s,
		:turn_full_house=>turn["full_house"].to_s,
		:turn_four_kind=>turn["four_kind"].to_s,
		:turn_straight_flush=>turn["straight_flush"].to_s}

	return json j


end

