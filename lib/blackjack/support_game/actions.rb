module Blackjack
  module SupportGame
    module Actions
      def perform_action
        cli_notification.notify(:perform_action)
        action = gets.strip

        case action.to_sym
        when :split
          split
        when :hit
          hit
        when :stand
          cli_notification.notify(:stand)
          stand
        when :double
          double
        when :exit
          return action
        else
          perform_action
        end

        action
      end

      def split
        player.hand_on_split.cards << player.hand.cards.shift(1)[0]
        player.take_cards croupier.deck.take(1), player.hand_on_split
        player.take_cards croupier.deck.take(1), player.hand

        dealer.hand_on_split.cards << dealer.hand.cards.shift(1)[0]
        dealer.take_cards croupier.deck.take(1), dealer.hand_on_split
        dealer.take_cards croupier.deck.take(1), dealer.hand
      end

      def stand
        determine_winner
      end

      def hit
        player.take_cards(croupier.deck.take)
        cli_notification.notify(:hit)

        if score_bust?(player.score(player.hand))
          determine_winner
        else
          perform_action
        end
      end

      def double
        croupier.rate_step
        player.take_cards(croupier.deck.take)

        cli_notification.notify(:double)

        determine_winner
      end
    end
  end
end
