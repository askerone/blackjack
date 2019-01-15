module Blackjack
  class Hand
    attr_reader :cards

    def initialize

      @cards = []
    end

    def take_card(deck_card)
      cards << deck_card
    end

    def take_cards(deck_cards)
      deck_cards.each { |card| cards << card }
    end

    def clear_cards
      cards.clear
    end

    def score
      Scoring.calculate_total(cards)
    end
  end
end
