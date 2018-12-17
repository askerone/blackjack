require 'spec_helper'

require 'blackjack/player'

require 'blackjack/card'
require 'blackjack/scoring'

require 'blackjack/support/config'

RSpec.describe Blackjack::Player do
  let(:hand)   { build :hand, player: player }
  let(:player) { build :player }

  let(:config) { Blackjack::Support::Config }

  before { player.hand = hand }

  describe '#take_cards' do
    let(:cards) { build :card }

    subject { player.take_card(cards) }

    it { expect { subject }.to change { player.cards.count }.by(1) }

    context 'when multiple cards' do
      let(:cards) do
        [
          build(:card),
          build(:card)
        ]
      end

      subject { player.take_cards(cards) }

      it { expect { subject }.to change { player.cards.count }.by(2) }
    end
  end

  describe '#take_bank' do
    let(:amount) { 10 }

    subject { player.take_bank(amount) }

    it { expect { subject }.to change { player.balance }.by(10) }
  end

  describe '#bet' do
    let(:amount) { config.fetch_setting(:minimum_bet) }

    subject { player.bet(amount) }

    it { expect { subject }.to change { player.balance }.by(-amount) }
  end

  describe '#total_score' do
    let(:card_1) { build :card, face: :'3',  suit: '♦' }
    let(:card_2) { build :card, face: :A,    suit: '♥' }
    let(:card_3) { build :card, face: :'8',  suit: '♦' }

    subject do
      player.take_card(card_1)
      player.take_card(card_2)
      player.take_card(card_3)
    end

    it 'returns player score' do
      subject
      expect(player.score).to eq 12
    end
  end
end
