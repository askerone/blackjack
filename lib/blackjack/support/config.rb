require 'singleton'

module Blackjack
  module Support
    class Config
      include Singleton

      DEFAULT_SETTINGS = {
        locale: :en,
        currency_symbol: :'$',
        player_balance: 1500,
        dealer_balance: 3000,
        minimum_bet: 10,
        dealer_name: 'Tricky John'
      }.freeze

      class << self
        def setting_attr_accessors
          @setting_attr_accessors = DEFAULT_SETTINGS.keys
        end

        def fetch_setting(name)
          instance.instance_variable_get(:"@#{name}") || DEFAULT_SETTINGS[name]
        end

        def translation
          @translation = Support::Locale.load(fetch_setting(:locale))
        end
      end

      attr_reader :translation
      attr_writer(*setting_attr_accessors)
    end
  end
end
