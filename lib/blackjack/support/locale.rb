require 'yaml'

module Blackjack
  module Support
    module Locale
      DIR    = 'config/locales'.freeze
      FORMAT = :yml

      def load(locale_name)
        YAML.load_file("#{DIR}/#{locale_name}.#{FORMAT}")
      end

      module_function :load

      def t(translation_path, variables={})
        translation_keys = translation_path.split('.')
        translation_keys.unshift(Config.fetch_setting(:locale).to_s)

        translation = Config.translation.dig(*translation_keys)
        translation = translation % variables unless variables.empty?

        raise ArgumentError if variable_passed?(variables, translation)

        translation
      end

      module_function :t

      private

        def variable_passed?(variable, translation, pattern=/\%{(.*?)\}/)
          variable.empty? && pattern =~ translation
        end

        module_function :variable_passed?
    end
  end
end
