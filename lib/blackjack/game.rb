require 'pry'
module Blackjack
  class Game
    include SupportGame::Rules
    include SupportGame::Actions

    attr_reader :player, :dealer, :croupier, :cli_notification

    def initialize
      @player = Player.new(
        name:    gets.chomp,
        balance: Support::Config.fetch_setting(:player_balance)
      )

      @dealer = Player.new(
        name:    Support::Config.fetch_setting(:dealer_name),
        balance: Support::Config.fetch_setting(:dealer_balance)
      )

      @player.hand = Hand.new
      @dealer.hand = Hand.new

      @croupier = SupportGame::Croupier.new(player, dealer)
      @cli_notification = Cli::Notification.new(self)
    end

    def start
      steps = 0
      loop do
        steps += 1
        croupier.change_deck!
        croupier.reset_bank!

        croupier.rate_step
        croupier.deal_cards
        cli_notification.notify(:game_start)
        if steps == 1 && player.hand.cards.first.face == player.hand.cards[1].face
          cli_notification.notify(:split)
          answer = gets.strip.downcase.to_sym
          if answer == :yes
            @player.hand_on_split = Hand.new
            @dealer.hand_on_split = Hand.new
            split
            cli_notification.notify_deal_cards
          end
        end
        action = perform_action

        break if quit?(action)
      end
    end

    private

      def quit?(action)
        action == 'exit'
      end
  end
end
