require 'pry'
module Blackjack
  module Cli
    class Notification
      include Helper

      attr_reader :game_instance, :player, :dealer, :croupier

      NOTIFICATIONS = {
        perform_action: -> { notify_perform_action },
        invalid_action: -> { notify_invalid_action },
        game_start:     -> { notify_game_start },
        hit:            -> { notify_hit },
        stand:          -> { notify_stand },
        double:         -> { notify_double },
        split:          -> { notify_split },
        draw:           -> { notify_draw },
        win:            -> { notify_win(player_name) }

      }.freeze

      def initialize(game_instance)
        @game_instance = game_instance

        @player = game_instance.player
        @dealer = game_instance.dealer
        @croupier = game_instance.croupier
      end

      def notify(action)
        block = NOTIFICATIONS.fetch(action.to_sym)
        instance_exec(&block)
      end

      def notify_win(winner_name:)
        clear

        display_cards player.name, player.cards
        display_score player.score

        display_cards dealer.name, dealer.cards
        display_score dealer.score

        display locale.t('cli.win', player_name: winner_name)
      end

      def notify_draw
        clear

        display_cards player.name, player.cards
        display_cards dealer.name, dealer.cards

        display locale.t('cli.draw')
      end

      def notify_perform_action
        display locale.t('game.player_step.actions')
      end

      def notify_invalid_action
        display locale.t('cli.invalid_action')
      end

      def notify_game_start
        notify_rate_step
        notify_deal_cards
      end

      def notify_hit
        clear

        display_cards player.name, player.cards
        display_score player.score

        if game_instance.score_bust?(player.score)
          display_cards dealer.name, dealer.cards
          display_score dealer.score
        else
          display_dealer_cards dealer.name, dealer.cards.first
        end
      end

      def notify_stand
        clear

        display_cards player.name, player.cards
        display_cards dealer.name, dealer.cards
      end

      def notify_double
        clear

        display_current_bank(croupier.bank)
        display_cards player.name, player.cards
        display_cards dealer.name, dealer.cards
      end

      def notify_split
        display_split_request
      end

      def notify_deal_cards
        display_cards player.name, player.cards
        display_score player.score
        if player.hand_on_split != nil
          display_cards player.name, player.hand_on_split.cards
          display_score player.hand_on_split.score
        end

        display_dealer_cards dealer.name, dealer.cards.first
      end

      def notify_rate_step
        display_current_bank(croupier.bank)

        display_cash(player.name, player.balance)
        display_cash(dealer.name, dealer.balance)
      end
    end
  end
end
