module Blackjack
  class Deck
    CARD_SUITS = ['♠', '♥', '♦', '♣'].freeze
    CARD_FACES = %i[2 3 4 5 6 7 8 9 10 J Q K A].freeze

    attr_reader :cards

    def initialize
      @cards = CARD_FACES.product(CARD_SUITS).map do |face, suit|
        Blackjack::Card.new(face, suit)
      end

      shuffle!
    end

    def shuffle!
      @cards.shuffle!
    end

    def take(qnt=1)
      cards.shift(qnt)
    end
  end
end
