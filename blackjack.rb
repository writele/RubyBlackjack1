def calculate_total(hand)
  arr = hand.map{|e| e[1]}

  total = 0
  arr.each do |value|
    if value == "Ace"
      total += 11
    elsif value.to_i == 0
      total += 10
    else
      total += value.to_i
    end
  end

  arr.select{|e| e == "Ace"}.count.times do
    if total > 21
      total -= 10
    end
  end

  total
end

def display_hand(player, hand, total)
  puts "#{player} has:" 
    hand.each do |card|
      print "#{card[1]} of #{card[0]}, "
    end
    puts "for a total of #{total}"
end

def display_upcard(hand, total)
  if total >= 21
    display_hand("Dealer", hand, total)
  else
    puts "Dealer has the upcard #{hand[0][1]} of #{hand[0][0]}" 
  end
end

puts "Welcome to Blackjack! What's your name?"
player_name = gets.chomp
player_money = 100

play_again = 'y'
begin
  ask_repeat = true
  begin
    puts "How much you wanna bet on this round? You currently have $#{player_money}"
    player_bet = gets.chomp.to_i
    if player_bet > player_money
      puts "You don't have enough money to bet that much!"
    else
      ask_repeat = false
    end 
  end until ask_repeat == false


  suits = ["Hearts", "Spades", "Diamonds", "Clubs"]
  cards = ["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King"]
  deck = suits.product(cards)

  deck.shuffle!

  dealer_hand = []
  player_hand = []

  player_hand << deck.pop
  dealer_hand << deck.pop
  player_hand << deck.pop
  dealer_hand << deck.pop

  dealer_total = calculate_total(dealer_hand)
  player_total = calculate_total(player_hand)
  puts ""
  display_upcard(dealer_hand, dealer_total) 
  display_hand(player_name, player_hand, player_total) 
  puts ""
  begin
    if dealer_total >= 21 || player_total >= 21
      break
    else
      puts "Hit or Stay? Enter 'h' or 's'."
      hit_or_stay = gets.chomp
      if hit_or_stay.downcase == 'h'
        player_hand << deck.pop
        dealer_total = calculate_total(dealer_hand)
        player_total = calculate_total(player_hand)
        display_upcard(dealer_hand, dealer_total) 
        display_hand(player_name, player_hand, player_total) 
        puts ""
      elsif hit_or_stay.downcase == 's'
        begin
          dealer_hand << deck.pop
          dealer_total = calculate_total(dealer_hand)
          player_total = calculate_total(player_hand)
          display_hand("Dealer", dealer_hand, dealer_total) 
          display_hand(player_name, player_hand, player_total)
          puts ""
        end until dealer_total > 17
        break
      end
    end
  end until dealer_total >= 21 || player_total >= 21

  if player_total == 21 && dealer_total == 21
    puts "#{player_name} and dealer are tied!"
  elsif player_total > 21
    puts "#{player_name} busts! Dealer wins!"
    player_money -= player_bet
  elsif player_total == 21
    puts "#{player_name} has 21! #{player_name} wins!"
    player_money += player_bet
  elsif dealer_total == 21
    puts "Dealer has 21! Dealer wins!" 
    player_money -= player_bet
  elsif dealer_total > 21
    puts "Dealer busts! #{player_name} wins!"
    player_money += player_bet
  elsif player_total > dealer_total
    puts "#{player_name} has higher total than dealer. #{player_name} wins!"
    player_money += player_bet
  elsif player_total < dealer_total
    puts "Dealer has higher total than #{player_name}. Dealer wins!"
    player_money -= player_bet
  elsif player_total == dealer_total
    puts "It's a tie!"  
  end

  if player_money <= 0 
    puts "You're outta money! Sorry, you can't play here anymore."
    play_again = 'n'
  else
    puts "You now have $#{player_money}. Play again? Enter 'y' or 'n'."
    play_again = gets.chomp
  end

end until play_again.downcase != 'y'
