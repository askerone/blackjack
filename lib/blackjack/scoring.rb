module Blackjack
  module Scoring
    ACE_SCORE_UPPER = 11
    ACE_SCORE_LOWER = 1

    NUMERICAL_CARDS_MAPPING_TABLE = {
      '10': 10, '9': 9, '8': 8,
      '7':  7,  '6': 6, '5': 5,
      '4':  4,  '3': 3, '2': 2
    }.freeze

    HIGH_CARDS_MAPPING_TABLE = {
      A: 11, K: 10,
      Q: 10, J: 10
    }.freeze

    def calculate(card)
      if face_ace?(card)
        proc { |total_score| ace_score_bust?(total_score) ? ACE_SCORE_UPPER : ACE_SCORE_LOWER }
      else
        convert_face_to_score(card.face)
      end
    end

    module_function :calculate

    def calculate_total(cards)
      cards = sort_by_face(cards)

      cards.inject(0) do |counter, card|
        counter + (card.score.is_a?(Integer) ? card.score : card.score.call(counter))
      end
    end

    module_function :calculate_total

    private

      def convert_face_to_score(face)
        @mapping_table ||= NUMERICAL_CARDS_MAPPING_TABLE.merge(HIGH_CARDS_MAPPING_TABLE)
        @mapping_table[face]
      end

      module_function :convert_face_to_score

      def sort_by_face(cards)
        cards.sort do |card, card_next|
          convert_face_to_score(card.face) <=> convert_face_to_score(card_next.face)
        end
      end

      module_function :sort_by_face

      def ace_score_bust?(total_score)
        (total_score + ACE_SCORE_UPPER) <= SupportGame::Rules::SCORE_LIMIT
      end

      module_function :ace_score_bust?

      def face_ace?(card)
        card.face == :A
      end

      module_function :face_ace?
  end
end
