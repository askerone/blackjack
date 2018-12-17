require 'spec_helper'

require 'blackjack/support/locale'
require 'blackjack/support/config'

RSpec.describe Blackjack::Support::Locale do
  let(:locale) { :en }
  let(:dir) { 'spec/fixtures' }

  before do
    stub_const('Blackjack::Support::Locale::DIR', dir)
  end

  describe '.load' do
    subject { described_class.load(locale) }

    it 'returns locale response' do
      expect(subject).to be_kind_of(Hash)
    end

    context 'when using another locale' do
      let(:locale) { :ru }

      it 'returns locale response' do
        expect(subject).to be_kind_of(Hash)
      end
    end
  end

  describe '.t' do
    let(:translation_path) { 'blackjack.example' }
    let(:variable) { {} }

    before { described_class.load(locale) }

    subject { described_class.t(translation_path, variable) }

    it 'returns translation' do
      expect(subject).to eq 'example'
    end

    context 'when passing variable' do
      let(:translation_path) { 'blackjack.example_var' }
      let(:name) { 'John Doe' }

      let(:variable) do
        {
          name: name
        }
      end

      it 'returns translation' do
        expect(subject).to eq "Hello #{name}"
      end

      context 'when passing multiple variables' do
        let(:translation_path) { 'blackjack.example_multiple' }

        let(:name) { 'John Doe' }
        let(:score) { 21 }

        let(:variables) do
          {
            name: name,
            score: score
          }
        end

        subject { described_class.t(translation_path, variables) }

        it 'returns translation' do
          expect(subject).to eq "Hello #{name}, score #{score}"
        end
      end

      context 'when not passing variable' do
        let(:variable) { {} }

        it 'raise error' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
