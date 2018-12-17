require 'spec_helper'

require 'blackjack/deck'

require 'blackjack/card'
require 'blackjack/scoring'

RSpec.describe Blackjack::Deck do
  let(:instance) { described_class.new }

  describe '#take' do
    let(:qnt) { 2 }

    subject { instance.take(qnt) }

    it 'take cards from deck' do
      cards = instance.cards.first(2)

      expect { subject }.to change { instance.cards.count }.by(-2)
      expect(subject).to eq cards
    end
  end
end
