module Blackjack
  class Player
    attr_accessor :hand, :hand_on_split
    attr_reader :name, :balance

    def initialize(name:, balance:)
      @name, @balance = name, balance
    end

    def take_bank(amount)
      @balance += amount
    end

    def bet(amount)
      @balance -= amount
      amount
    end

    def cards(current_hand=nil)
      current_hand ||= hand
      current_hand.cards
    end

    def take_card(deck_card, current_hand=nil)
      current_hand ||= hand
      current_hand.take_card(deck_card)
    end

    def take_cards(deck_cards, current_hand=nil)
      current_hand ||= hand
      current_hand.take_cards(deck_cards)
    end

    def clear_cards(current_hand=nil)
      current_hand ||= hand
      current_hand.clear_cards
    end

    def score(current_hand=nil)
      current_hand ||= hand
      current_hand.score
    end
  end
end
