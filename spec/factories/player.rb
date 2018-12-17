FactoryBot.define do
  factory :player, class: Blackjack::Player do
    name { 'John Doe' }
    balance { 1500 }

    initialize_with { new(name: name, balance: balance) }
  end
end
