module Elpresidente
  module Skills
    module Gentlemen
      class AskWhatYouWant < Skill
        RESPONSES = [
          'Czego chce?',
          'Chyba ty',
          'A mogłem zabić',
          'Może tak',
          'Albo nie',
          'Kakaka'
        ]

        def execute
          return unless author_id
          return unless mentioned? || personal?

          reply! RESPONSES.shuffle.first
          stop!
        end
      end
    end
  end
end