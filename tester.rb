require_relative "Card.rb"
require_relative "Dealer.rb"
require_relative "Deck.rb"

d = Dealer.new("3S","3C")
d.deal_community_cards(5)
d.has_straight