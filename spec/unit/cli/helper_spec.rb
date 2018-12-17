require 'spec_helper'
require 'blackjack/cli/helper'

RSpec.describe Blackjack::Cli::Helper do
  let(:locale) { Blackjack::Support::Locale }

  let(:klass) do
    Class.new do
      include Blackjack::Cli::Helper
    end
  end

  let(:instance) { klass.new }

  describe '#display' do
    let(:message) { 'Blackjack' }

    let(:output_message) do
      "#{message}\n\n"
    end

    subject { instance.display(message) }

    it 'display message' do
      expect { subject }.to output(output_message).to_stdout
    end
  end

  describe '#display_cards' do
    let(:player_name) { 'John Doe' }

    let(:cards) { build_list :card, 1 }
    let(:card)  { cards.first }

    let(:score) { 10 }

    let(:output_message) do
      "#{locale.t('cli.player_cards', player_name: player_name)}\n"\
      "#{card.face}#{card.suit}\n\n"
    end

    subject { instance.display_cards(player_name, cards) }

    it 'display player cards' do
      expect { subject }.to output(output_message).to_stdout
    end
  end

  describe '#display_dealer_cards' do
    let(:dealer_name) { 'Tricky John' }

    let(:cards) { build_list :card, 1 }
    let(:card) { cards.first }

    let(:output_message) do
      "#{locale.t('cli.player_cards', player_name: dealer_name)}\n"\
      "#{card.face}#{card.suit}\n"\
      "#{locale.t('cli.unknown_card_face')}\n\n"
    end

    subject { instance.display_dealer_cards(dealer_name, card) }

    it 'display dealer cards' do
      expect { subject }.to output(output_message).to_stdout
    end
  end

  describe '#display_score' do
    let(:score) { 10 }

    let(:output_message) do
      "#{locale.t('cli.total_score', score: score)}\n\n"
    end

    subject { instance.display_score(score) }

    it 'display score' do
      expect { subject }.to output(output_message).to_stdout
    end
  end

  describe '#display_current_bank' do
    let(:bank_cash) { 10 }

    let(:output_message) do
      "#{locale.t('cli.current_bank', bank_cash: bank_cash)}\n\n"
    end

    subject { instance.display_current_bank(bank_cash) }

    it 'display current bank' do
      expect { subject }.to output(output_message).to_stdout
    end
  end

  describe '#display_cash' do
    let(:player_name) { 'John Doe' }
    let(:player_balance) { 10 }

    let(:output_message) do
      "#{locale.t('cli.balance', player_name: player_name, balance: player_balance)}\n"
    end

    subject { instance.display_cash(player_name, player_balance) }

    it 'display cash' do
      expect { subject }.to output(output_message).to_stdout
    end
  end
end
