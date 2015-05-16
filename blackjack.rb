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

def check_ace(hand, score, deck)
  aces = deck.select {|k, v| /^Ace/.match(k)}.keys
  if !(hand & aces).empty? && score < 12
  score = score + 10
  end
end

def deal_new_card(hand, score, deck)
  new_card = deck.select{|k, v| v[1] == false}.keys.sample
  deck[new_card][1] = true
  hand.push(new_card)
  score = score + deck[new_card][0]
end

def show_hands(player_hand, dealer_hand)
  puts "Player's hand is #{player_hand}"
  puts "Dealer's hand is #{dealer_hand}"
end

def check_blackjack(player, hand, deck)
  aces = deck.select {|k, _| /^Ace/.match(k)}.keys
  suites = deck.select {|k, _| /^King|Queen|Jack/.match(k)}.keys
  if hand.length == 2 && !(hand & aces).empty? && !(hand & suites).empty?
    end_game("Player")
    return true
  end
end

def check_score(player, score)
  if score > 21
    winner = "#{player} busts"
  elsif score == 21
    winner = player
  end
end

def dealer_turn
  begin
    deal_new_card(dealer_hand, dealer_score, new_deck)
    show_hands(player_hand, dealer_hand)
    if check_score("Dealer", dealer_score)
      end_game(winner)
    end
  end until dealer_score > 17
  if dealer_score > player_score
    end_game("Dealer")
  elsif dealer_score < player_score
    end_game("Player")
  end
end

def end_game(winner)
  if winner == "Player" || winner == "Dealer"
    puts "#{winner} wins!"
  elsif winner == "Player busts" || winner == "Dealer busts"
    puts "#{winner}!"
  end
  puts "Game over. Play again? Y/N"
  play_again = gets.chomp
  if play_again.upcase == "Y"
    end_game == false
  else
    end_game == true   
  end
end


begin
  new_deck = deck_of_cards
  deal_new_card(player_hand, player_score, new_deck)
  deal_new_card(player_hand, player_score, new_deck)
  deal_new_card(dealer_hand, dealer_score, new_deck)
  deal_new_card(dealer_hand, dealer_score, new_deck)
  show_hands(player_hand, dealer_hand)
  if check_score("Player", player_score)
    end_game(winner)
  elsif check_score("Dealer", dealer_score)
    end_game(winner)
  else
    begin
      puts "Hit or Stay? Enter 'h' or 's'."
      player_choice = gets.chomp
      if player_choice.downcase == "h"
        deal_new_card(player_hand, player_score, new_deck)
        show_hands(player_hand, dealer_hand)
          if check_score("Player", player_score)
            end_game(winner)
          end
      elsif player_choice.downcase == "s"
        dealer_turn
      end
    end until dealer_turn || end_game(winner)
  end
end until end_game(winner) == true


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