module Blackjack
  module Cli
    module Helper
      def display(message)
        $stdout.puts message
        $stdout.puts
      end

      def display_cards(player_name, cards)
        $stdout.puts locale.t('cli.player_cards', player_name: player_name)

        cards.each do |card|
          $stdout.puts "#{card.face}#{card.suit}"
        end

        $stdout.puts
      end

      def display_dealer_cards(dealer_name, card)
        $stdout.puts locale.t('cli.player_cards', player_name: dealer_name)

        $stdout.puts "#{card.face}#{card.suit}"
        $stdout.puts locale.t('cli.unknown_card_face')

        $stdout.puts
      end

      def display_score(score)
        $stdout.puts locale.t('cli.total_score', score: score)
        $stdout.puts
      end

      def display_current_bank(bank_cash)
        $stdout.puts locale.t('cli.current_bank', bank_cash: bank_cash)
        $stdout.puts
      end

      def display_cash(player_name, player_balance)
        $stdout.puts locale.t('cli.balance', player_name: player_name, balance: player_balance)
      end

      def clear
        system('clear')
      end

      private

        def locale
          Support::Locale
        end
    end
  end
end
