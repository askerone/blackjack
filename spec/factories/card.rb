FactoryBot.define do
  factory :card, class: Blackjack::Card do
    face { Blackjack::Deck::CARD_FACES.sample }
    suit { Blackjack::Deck::CARD_SUITS.sample }

    initialize_with { new(face, suit) }
  end
end
