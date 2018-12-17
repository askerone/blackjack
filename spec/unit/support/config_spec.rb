require 'spec_helper'

require 'blackjack'
require 'blackjack/support/config'

RSpec.describe Blackjack::Support::Config do
  let(:default_setting) { described_class::DEFAULT_SETTINGS }

  it 'return default values' do
    expect(described_class.fetch_setting(:locale)).to eq default_setting[:locale]

    expect(described_class.fetch_setting(:player_balance)).to  eq default_setting[:player_balance]
    expect(described_class.fetch_setting(:dealer_balance)).to  eq default_setting[:dealer_balance]
    expect(described_class.fetch_setting(:currency_symbol)).to eq default_setting[:currency_symbol]
    expect(described_class.fetch_setting(:minimum_bet)).to eq default_setting[:minimum_bet]
  end

  context 'when provided value' do
    let(:locale) { :cz }

    let(:player_balance)  { 2000 }
    let(:dealer_balance)  { 3500 }
    let(:minimum_bet)     { 15 }
    let(:dealer_name)     { 'John Doe' }
    let(:currency_symbol) { :'€' }

    before do
      Blackjack.setup do |config|
        config.locale = locale

        config.player_balance  = player_balance
        config.dealer_balance  = dealer_balance
        config.minimum_bet     = minimum_bet
        config.dealer_name     = dealer_name
        config.currency_symbol = currency_symbol
      end
    end

    it { expect(described_class.fetch_setting(:locale)).to eq locale }
    it { expect(described_class.fetch_setting(:player_balance)).to eq player_balance }
    it { expect(described_class.fetch_setting(:dealer_balance)).to eq dealer_balance }
    it { expect(described_class.fetch_setting(:minimum_bet)).to eq minimum_bet }
    it { expect(described_class.fetch_setting(:dealer_name)).to eq dealer_name }
    it { expect(described_class.fetch_setting(:currency_symbol)).to eq currency_symbol }
  end
end
