require 'spec_helper'
require 'blackjack/scoring'

RSpec.describe Blackjack::Scoring do
  describe '.calculate' do
    let(:cards_with_numeric_faces) { (2..10).map { |face| build :card, face: face.to_s.to_sym } }

    subject do
      proc { |card| described_class.calculate(card) }
    end

    it 'return card score' do
      cards_with_numeric_faces.each do |card|
        expect(subject.call(card)).to eq card.face.to_s.to_i
      end
    end

    context 'when high cards' do
      let(:high_card_score) { 10 }

      let(:cards) do
        %i[K Q J].map do |face|
          build :card, face: face
        end
      end

      it 'return card score' do
        cards.each { |card| expect(subject.call(card)).to eq high_card_score }
      end
    end

    context 'when card is ace' do
      let(:card) { build :card, face: :A }

      it 'return proc' do
        expect(subject.call(card).class).to eq Proc
      end
    end
  end

  describe '.calculate_total' do
    let(:cards) do
      [
        build(:card, face: :A),
        build(:card, face: :'10')
      ]
    end

    subject { described_class.calculate_total(cards) }

    it 'return cards total score' do
      expect(subject).to eq 21
    end
  end
end
