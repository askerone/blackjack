module Blackjack
  module SupportGame
    class Croupier
      attr_reader :player, :dealer, :bank, :deck

      def initialize(player, dealer, bank=0)
        @player, @dealer = player, dealer

        @bank = bank
        @deck = Blackjack::Deck.new
      end

      def deal_cards
        dealer.take_cards deck.take(2)
        player.take_cards deck.take(2)
      end

      def rate_step
        @bank += player.bet(minimum_bet)
        @bank += dealer.bet(minimum_bet)
      end

      def change_deck!
        @deck = Deck.new
      end

      def reset_bank!
        @bank = 0
      end

      private

        def minimum_bet
          Support::Config.fetch_setting(:minimum_bet)
        end
    end
  end
end
