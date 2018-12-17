FactoryBot.define do
  factory :hand, class: Blackjack::Hand do
    initialize_with { new(player) }
  end
end
