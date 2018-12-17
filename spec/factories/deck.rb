FactoryBot.define do
  factory :deck, class: Blackjack::Deck do
    initialize_with { new }
  end
end
