play_again = 'y'
begin

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

puts "Dealer has #{dealer_hand[0]} and #{dealer_hand[1]}, for a total of #{dealer_total}"
puts "You have #{player_hand[0]} and #{player_hand[1]}, for a total of #{player_total}"
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
      puts "Dealer has #{dealer_hand}, for a total of #{dealer_total}"
      puts "Player has #{player_hand}, for a total of #{player_total}"
      puts ""
    elsif hit_or_stay.downcase == 's'
      begin
        dealer_hand << deck.pop
        dealer_total = calculate_total(dealer_hand)
        player_total = calculate_total(player_hand)
        puts "Dealer has #{dealer_hand}, for a total of #{dealer_total}"
        puts "Player has #{player_hand}, for a total of #{player_total}"
        puts ""
      end until dealer_total > 17
      break
    end
  end
end until dealer_total >= 21 || player_total >= 21

if player_total == 21 && dealer_total == 21
  puts "Player and dealer are tied!"
elsif player_total > 21
  puts "Player busts! Dealer wins!"
elsif player_total == 21
  puts "Player has 21! Player wins!"
elsif dealer_total == 21
  puts "Dealer has 21! Dealer wins!" 
elsif dealer_total > 21
  puts "Dealer busts! Player wins!"
elsif player_total > dealer_total
  puts "Player has higher total than dealer. Player wins!"
elsif player_total < dealer_total
  puts "Dealer has higher total than player. Dealer wins!"
elsif player_total == dealer_total
  puts "It's a tie!"  
end

puts "Game over. Play again? Enter 'y' or 'n'."
play_again = gets.chomp

end until play_again.downcase != 'y'










