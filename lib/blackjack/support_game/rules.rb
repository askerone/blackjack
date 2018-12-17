module Blackjack
  module SupportGame
    module Rules
      SCORE_LIMIT = 21
      NEXT_GAME_DELAY = 3

      def determine_winner
        player_score = player.score(player.hand)
        dealer_score = dealer.score(dealer.hand)

        if player_win?(player_score, dealer_score)
          cli_notification.notify_win(winner_name: player.name)
          player.take_bank(croupier.bank)
        elsif dealer_win?(player_score, dealer_score)
          cli_notification.notify_win(winner_name: dealer.name)
          dealer.take_bank(croupier.bank)
        elsif draw?(player_score, dealer_score)
          cli_notification.notify(:draw)

          bank = croupier.bank / 2

          player.take_bank(bank)
          dealer.take_bank(bank)
        end

        player.clear_cards(player.hand)
        dealer.clear_cards(dealer.hand)

        sleep(NEXT_GAME_DELAY)
      end

      def player_win?(player_score, dealer_score)
        (player_score > dealer_score || score_bust?(dealer_score)) && !score_bust?(player_score)
      end

      def dealer_win?(player_score, dealer_score)
        (dealer_score > player_score || score_bust?(player_score)) && !score_bust?(dealer_score)
      end

      def draw?(player_score, dealer_score)
        player_score == dealer_score
      end

      def score_bust?(total_score)
        total_score > SCORE_LIMIT
      end
    end
  end
end
