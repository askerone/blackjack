module Blackjack
  class Card
    attr_accessor :score
    attr_reader :face, :suit

    def initialize(face, suit)
      @face, @suit = face, suit
      @score = Scoring.calculate(self)
    end
  end
end
