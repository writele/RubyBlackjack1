require 'pry'

deck_of_cards = {}
card_types = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
card_types.each do |card| 
  if card == "Jack" || card == "Queen" || card == "King"
    deck_of_cards["#{card} of Hearts"] = [10, false]
    deck_of_cards["#{card} of Spades"] = [10, false]
    deck_of_cards["#{card} of Diamonds"] = [10, false]
    deck_of_cards["#{card} of Clubs"] = [10, false]
  else
    deck_of_cards["#{card} of Hearts"] = [card_types.index(card) + 1, false]
    deck_of_cards["#{card} of Spades"] = [card_types.index(card) + 1, false]
    deck_of_cards["#{card} of Diamonds"] = [card_types.index(card) + 1, false]
    deck_of_cards["#{card} of Clubs"] = [card_types.index(card) + 1, false]
  end
end

dealer_hand = []
player_hand = []
dealer_score = 0
player_score = 0

def check_if_ace(hand, score, deck)
  aces = deck.select {|k, v| /^Ace/.match(k)}.keys
  if !(hand & aces).empty? && score < 12
  score = score + 10
end


# Deal two cards to player and dealer
def deal_new_card(hand, score, deck)
  new_card = deck_of_cards.select{|k, v| v[1] == false}.keys.sample
  deck_of_cards[new_card][1] == true
  hand.push = new_card
  score = score + deck_of_cards[new_card][0]
end

def show_hands(player_hand, dealer_hand)
  puts "Player's hand is #{player_hand}"
  puts "Dealer's hand is #{dealer_hand}"
end

def check_blackjack(hand, deck)
  aces = deck.select {|k, v| /^Ace/.match(k)}.keys
  suites = deck.select {|k, v| /^King|Queen|Jack/.match(k)}.keys
  if hand.length == 2 && !(hand & aces).empty? && !(hand & suites).empty?
    return true
  end
end

def winner
  puts "#{player} wins!"
  break
end

new_deck = deck_of_cards
begin
  deal_new_card(player_hand, player_score, new_deck)
  deal_new_card(player_hand, player_score, new_deck)
  deal_new_card(dealer_hand, dealer_score, new_deck)
  deal_new_card(dealer_hand, dealer_score, new_deck)
  show_hands
  if check_blackjack(player_hand, new_deck) || 
    winner
  else
  puts "Hit or Stay?"


# Player chooses to hit or stay
#   show hands
#   Hit or Stay?
#   If player hits
#     over 21? player loses
#     21? or check_blackjack(suite + ace): player wins
#     else repeat choice
#   If play stays, turn moves to dealer
# Dealer hits unless dealer score = 17
#   if dealer score 21 or check_blackjack, dealer wins
#   over 21? dealer loses
#   else player turn
# show hands
end