lib = File.expand_path('lib')
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

module Blackjack
  require 'blackjack/player'

  require 'blackjack/deck'
  require 'blackjack/card'
  require 'blackjack/hand'

  require 'blackjack/scoring'

  module Support
    require 'blackjack/support/locale'
    require 'blackjack/support/config'
  end

  module SupportGame
    require 'blackjack/support_game/actions'
    require 'blackjack/support_game/croupier'
    require 'blackjack/support_game/rules'
  end

  module Cli
    require 'blackjack/cli/helper'
    require 'blackjack/cli/notification'
  end

  require 'blackjack/game'

  class << self
    def run
      game = Game.new
      game.start
    end

    def setup
      yield(Support::Config.instance)
    end
  end
end
